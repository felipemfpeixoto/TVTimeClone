//
//  ViewController.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 05/02/25.
//

import UIKit
import CodableExtensions

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var SelectShows: UIView!
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    var results:[TVShow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do {
            let _ = try TVShowsManager.load()
            performSegue(withIdentifier: "CreateWatchlist", sender: nil)
        } catch {
            print("Ainda não criou a watchlist")
        }
        
        collectionView.register(PosterCellCollectionView.nib(), forCellWithReuseIdentifier: PosterCellCollectionView.identifier)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let welcome = Welcome.loadFromBundle()
        results = welcome?.results ?? []
        print("Results: \(results.count)")
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("Fui selecionado \(indexPath.row)")
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCellCollectionView.identifier, for: indexPath) as! PosterCellCollectionView
        
        cell.configure(with: results[indexPath.row])
        
        return cell
    }
    
}

// MARK: Lets us determine what is the margin and padding between each cell
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 112, height: 189)
    }
}
