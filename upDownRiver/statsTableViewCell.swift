//
//  statsTableViewCell.swift
//  upDownRiver
//
//  Created by bergerMacPro on 8/28/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class statsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameDisplay: UILabel!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var currentSteakDisplay: UILabel!
    @IBOutlet weak var longestStreakDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
