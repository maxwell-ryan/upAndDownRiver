//
//  playHandVC.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/23/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class playHandVC: UIViewController {

    @IBOutlet weak var currRoundDisplay: UILabel!
    @IBOutlet weak var roundProgressBar: UIProgressView!
    @IBOutlet weak var detailLabel: UILabel!
    

    override func viewDidAppear(_ animated: Bool) {
        
        roundProgressBar.progressTintColor = colorScheme.apricot
        roundProgressBar.trackTintColor = colorScheme.blueberry
        roundProgressBar.setProgress(Float(Game.myGame.currRound) / Float(Game.myGame.numRounds), animated: true)
        
        currRoundDisplay.textColor = colorScheme.blueberry
        currRoundDisplay.font = UIFont.boldSystemFont(ofSize: 15)
        currRoundDisplay.text = "Round \(Game.myGame.currRound)"
        
        detailLabel.textColor = colorScheme.blueberry
        
        for index in 0...Game.myGame.numPlayers - 1 {
            
            if Game.myGame.overallRound > 1 {
                detailLabel.text!.append("\(Game.myGame.currPlayers[index].name) - Score: \(Game.myGame.currPlayers[index].getOverallScore()) - Bid: \(Game.myGame.currPlayers[index].getBid())\n")
            } else {
                detailLabel.text!.append("\(Game.myGame.currPlayers[index].name) - Score: 0 - Bid: \(Game.myGame.currPlayers[index].getBid())\n")
            }
        
        }
    
    }
    
    @IBAction func viewGameStats(_ sender: Any) {
        performSegue(withIdentifier: "showGameStateDetails", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
