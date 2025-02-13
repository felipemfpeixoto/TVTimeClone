//
//  WatchlistCellCollectionView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

class WatchListViewCell: UICollectionViewCell {
    
    
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
