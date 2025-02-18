//
//  ChooseWatchlistView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class ChooseWatchlistViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var SelectShows: UIView!
    
    var results:[TVShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        do {
            let _ = try TVShowsManager.load()
            performSegue(withIdentifier: "ToolBar", sender: nil)
        } catch {
            print("Ainda não criou a watchlist")
        }
        
        // Do any additional setup after loading the view.
        collectionView.register(WatchListViewCell.nib(), forCellWithReuseIdentifier: WatchListViewCell.identifier)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let welcome = Welcome.loadFromBundle()
        
        let filteredResults = welcome?.results.filter { TVShowsManager.shared.watchedTvShow.contains($0) == false }
        
        results = filteredResults ?? []
    }
}

extension ChooseWatchlistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("Fui selecionado \(indexPath.row)")
    }
}

extension ChooseWatchlistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 - TVShowsManager.shared.watchedTvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchListViewCell.identifier, for: indexPath) as! WatchListViewCell
        
        cell.configure(with: results[indexPath.row])
        
        return cell
    }
    
}

// MARK: Lets us determine what is the margin and padding between each cell
extension ChooseWatchlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 112, height: 189)
    }
}
