//
//  gameOverVC.swift
//  upDownRiver
//
//  Created by maxwell on 9/21/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit


class gameOverViewController: UIViewController {
    
    @IBOutlet weak var winnerHeaderLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //move labels out of view bounds before animated in view bounds
        winnerHeaderLabel.center.y += view.bounds.height
        winnerLabel.center.y += view.bounds.height
        
        var winnerIdx = 0
        var winningScore = 0
        
        for x in 0..<Game.myGame.numPlayers {
            
            if (Game.myGame.currPlayers[x].currentScore > winningScore) {
                
                winningScore = Game.myGame.currPlayers[x].currentScore
                winnerIdx = x
            
            }
        }
        
        winnerLabel.text = Game.myGame.currPlayers[winnerIdx].icon + " " + Game.myGame.currPlayers[winnerIdx].name
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 4) {
            self.winnerHeaderLabel.center.y -= self.view.bounds.height
        }
        
        UIView.animate(withDuration: 6) {
            self.winnerLabel.center.y -= self.view.bounds.height
        }
    }
    
}
