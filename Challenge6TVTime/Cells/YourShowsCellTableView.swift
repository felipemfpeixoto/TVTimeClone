//
//  YourShowsCellTableView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

protocol YourShowsCellTableViewDelegate: AnyObject {
    func didTapButton(in cell: YourShowsCellTableView)
}

class YourShowsCellTableView: UITableViewCell {
    
    static let identifier = "YourShowsCellTableView"
    
    weak var delegate: YourShowsCellTableViewDelegate?
    
    var tvShow: TVShow?

    @IBOutlet weak var showsImage: UIImageView!
    
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    
    @IBOutlet weak var titleEpisodeLabel: UILabel!

    @IBOutlet weak var moreInformationButton: UIButton!
    
    @IBOutlet weak var watchedEpisodeButton: UIButton!
    
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        watchedEpisodeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        delegate?.didTapButton(in: self)
    }
    
    func configure(with item: TVShow) {
        self.tvShow = item
        self.showsImage.image = UIImage(systemName: "photo")
        self.seasonAndEpisodeLabel.text = tvShow?.name
        self.titleEpisodeLabel.text = tvShow?.mediaType
        
        self.background.layer.cornerRadius = 20
        
        Task {
            @MainActor in
            do {
                self.showsImage.image = try await TMDBService.requestImage(from: item.posterPath)
            } catch {
                self.showsImage.image = UIImage(systemName: "photo")
            }
        }
        
//        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 20
        
        self.showsImage.contentMode = .scaleAspectFit
    }
    
    // MARK: Function called to register the cell to the collection view
    static func nib() -> UINib {
        return UINib(nibName: Self.identifier, bundle: nil)
    }
}
