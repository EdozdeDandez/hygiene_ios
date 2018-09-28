//
//  HomeTableViewCell.swift
//  Hygiene
//
//  Created by Edith Dande on 06/04/2018.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
