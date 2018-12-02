//
//  ElementTableViewCell.swift
//  to-do-list
//
//  Created by Nick Kazan on 2018-12-01.
//  Copyright © 2018 Nick Kazan. All rights reserved.
//

import UIKit
class ElementTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
