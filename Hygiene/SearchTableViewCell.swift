//
//  SearchTableViewCell.swift
//  Hygiene
//
//  Created by Edith Dande on 08/04/2018.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    // MARK: - variables
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
