//
//  YourShowsCellTableView.swift
//  Challenge6TVTime
//
//  Created by Ana Zacour on 12/02/25.
//

import UIKit

class YourShowsCellTableView: UITableViewCell {

    
    @IBOutlet weak var showsImage: UIImageView!
    
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    
    @IBOutlet weak var titleEpisodeLabel: UILabel!

    @IBOutlet weak var moreInformationButton: UIButton!
    
    @IBOutlet weak var watchedEpisodeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
