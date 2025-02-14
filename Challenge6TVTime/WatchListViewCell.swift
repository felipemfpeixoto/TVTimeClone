//
//  WatchlistCellCollectionView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

class WatchListViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var buttonWatched: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    static let identifier: String = "WatchListViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with string: String) {
//        watchedPosterImage.image = UIImage(named: string)
        backgroundColor = .blue
        print(string)
        imageView.image = UIImage(systemName: "photo")
//        watchedPosterImage.image = UIImage(systemName: "photo.artframe")
    }
    
    // MARK: Function called to register the cell to the collection view
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}


/*
 
 eyJhbGciOiJIUzI1NiJ.eyJhdWQiOiI1YjQ4OTYyMzcxMDk4ZTgzOWU2NmQ1ZGU3Yzg4Y2YxMiIsIm5iZiI6MTczOTU1NDMwMy45ODgsInN1YiI6IjY3YWY3ZGZmYzQ2ZmI3YzA5ZTNiNjkwYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B-GIFlD3h5SsQno0e8ruaE91-quoVFmWVZoHGo_CTDk
 
 5b48962371098e839e66d5de7c88cf12
 
 */
