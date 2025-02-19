//
//  ExploreView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet var SelectShows: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var results:[TVShow] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.register(PosterCellCollectionView.nib(), forCellWithReuseIdentifier: PosterCellCollectionView.identifier)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let welcome = Welcome.loadFromBundle()
        
        let auxResults = welcome?.results.filter { TVShowsManager.shared.watchedTvShow.contains($0) == false }
        
        results = auxResults ?? []
    }
    
    // MARK: Essa função receberá um TVShow para ser adicionado
    func showAlert(tappedTvShow: TVShow) {
        let alert = UIAlertController(title: "Add TV Show", message: "Are you sure you want do add \(tappedTvShow.name) to your watchlist?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            TVShowsManager.shared.addPlanned(tappedTvShow)
            
            self.results.remove(at: self.results.firstIndex(of: tappedTvShow)!)
            self.collectionView.reloadData()
        }))
        
        present(alert, animated: true)
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCellCollectionView.identifier, for: indexPath) as! PosterCellCollectionView
        
        cell.configure(with: results[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        showAlert(tappedTvShow: results[indexPath.row])
    }
}


// MARK: Lets us determine what is the margin and padding between each cell
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: 189)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // MARK: Aqui dentro dessa função, devo fazer um filter do results para ver se o nome da série pesquisada contém o input do usuário
        if searchText.isEmpty {
            let welcome = Welcome.loadFromBundle()
            let auxResults = welcome?.results.filter { TVShowsManager.shared.watchedTvShow.contains($0) == false } ?? []
            self.results = auxResults
        } else {
            self.results = results.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        
        collectionView.reloadData()
    }
}
