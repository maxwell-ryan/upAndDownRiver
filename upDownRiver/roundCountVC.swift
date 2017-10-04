//
//  roundCountVC.swift
//  upDownRiver
//
//  Created by maxwell on 9/21/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit

class roundCountViewController: UIViewController {
    
    
    @IBOutlet weak var roundCountStepper: UIStepper!
    @IBOutlet weak var confirmRoundCountBtn: UIButton!
    @IBOutlet weak var roundCountLabel: UILabel!
    @IBOutlet weak var roundCountPromptLabel: UILabel!
    
    @IBAction func roundCountValueChanged(_ sender: Any) {
        
        //set number of rounds game to user selection * 2 - 1
        //user selects max round count, hence * 2 - 1 computation
        Game.myGame.numRounds = (Int(roundCountStepper.value) * 2) - 1
        Game.myGame.apexRound = Int(roundCountStepper.value)
        
        roundCountLabel.text = String(roundCountStepper.value)
        
        
    }

    @IBAction func roundCountConfirmed(_ sender: Any) {
        performSegue(withIdentifier: "getBids", sender: sender)
    }
    
    var suggestedCount: Int {
        
        get {
            if ((52 / Game.myGame.numPlayers) >= 9) {
                return 9
            } else {
                return (52 / Game.myGame.numPlayers)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //max value is max divisible by number of players
        roundCountStepper.maximumValue = Double(52 / Game.myGame.numPlayers)
        roundCountStepper.minimumValue = 2.0
        
        roundCountStepper.value = Double(suggestedCount)
        roundCountLabel.text = String(roundCountStepper.value)

    }
}
