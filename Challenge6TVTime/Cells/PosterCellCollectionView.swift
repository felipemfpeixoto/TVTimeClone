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
        if TVShowsManager.shared.watchedTvShow.contains(where: { $0.id == self.tvShow!.id }) {
            TVShowsManager.shared.removeWatched(self.tvShow!)
            
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            
            self.addShowButton.setImage(UIImage(systemName: "plus", withConfiguration: configuration), for: .normal)
            
        } else {
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
        
        do {
            let _ = try TVShowsManager.load()
            self.addShowButton.isEnabled = false
            self.addShowButton.layer.opacity = 0
        } catch {
            print("Não existe nenhum TVShowsManager salvo na memória, logo o botao continua ativo")
        }
    }
    
    // MARK: Function called to register the cell to the collection view
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
