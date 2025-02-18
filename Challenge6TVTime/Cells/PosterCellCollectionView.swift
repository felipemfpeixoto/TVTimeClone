//
//  PosterCellCollectionView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

class PosterCellCollectionView: UICollectionViewCell {
    
    var tvShow: TVShow?
    
    @IBOutlet weak var addShowButton: UIButton!
    
    @IBOutlet weak var addPosterImage: UIImageView!
    
    static let identifier: String = "PosterCellCollectionView"
    
    
    @IBAction func clickedButton(_ sender: Any) {
        print("Clicou")
        
        if TVShowsManager.shared.watchedTvShow.contains(where: { $0.id == self.tvShow!.id }) {
            print("Deu red")
            TVShowsManager.shared.removeWatched(self.tvShow!)
            
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            
            self.addShowButton.setImage(UIImage(systemName: "plus", withConfiguration: configuration), for: .normal)
            
        } else {
            print("Deu add")
            TVShowsManager.shared.addWatched(self.tvShow!)
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            self.addShowButton.setImage(UIImage(systemName: "minus", withConfiguration: configuration), for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: TVShow) {
        
        self.addPosterImage.image = UIImage(systemName: "photo")
        
        self.tvShow = item
        
        Task {
            @MainActor in
            do {
                self.addPosterImage.image = try await TMDBService.requestImage(from: item.posterPath)
            } catch {
                self.addPosterImage.image = UIImage(systemName: "photo")
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
