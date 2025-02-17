//
//  PosterCellCollectionView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

class PosterCellCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var addShowButton: UIButton!
    
    @IBOutlet weak var addPosterImage: UIImageView!
    
    static let identifier: String = "PosterCellCollectionView"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: Result) {
        
        self.addPosterImage.image = UIImage(systemName: "photo")
        
        Task {
            @MainActor in
            do {
                self.addPosterImage.image = try await TMDBService.requestImage(from: item.posterPath)
                print("Pegou a imagem")
            } catch {
                self.addPosterImage.image = UIImage(systemName: "photo")
                print("Não Pegou a imagem")
            }
        }
        
        self.addPosterImage.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 8
    }
    
    // MARK: Function called to register the cell to the collection view
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
