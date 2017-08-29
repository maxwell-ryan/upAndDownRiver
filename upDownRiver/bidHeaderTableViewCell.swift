//
//  bidHeaderTableViewCell.swift
//  upDownRiver
//
//  Created by bergerMacPro on 8/28/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class bidHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var roundProgressDisplay: UIProgressView!
    @IBOutlet weak var dealerDisplay: UILabel!
    @IBOutlet weak var roundDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
