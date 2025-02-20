//
//  DescriptionShowsView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 11/02/25.
//

import UIKit

class DescriptionShowsViewController: UIViewController {
    
    var tvShow: TVShow?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var showDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showDescription.text = tvShow?.overview ?? "No Description"
        self.imageView.image = UIImage(systemName: "photo")
        Task {
            @MainActor in
            do {
                self.imageView.image = try await TMDBService.requestImage(from: tvShow?.posterPath ?? "")
            } catch {
                self.imageView.image = UIImage(systemName: "photo")
            }
        }
        self.imageView.contentMode = .scaleAspectFit
    }


}
