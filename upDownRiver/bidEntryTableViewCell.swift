//
//  bidEntryTableViewCell.swift
//  upDownRiver
//
//  Created by maxwell on 8/26/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class bidTrickEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var bidDisplay: UILabel!
    @IBOutlet weak var bidSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
