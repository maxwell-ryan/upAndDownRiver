//
//  playerNameScreenViewController.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/20/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class playerNameScreenViewController: UIViewController {
    
    @IBOutlet weak var playerNamePrompt: UILabel!
    @IBOutlet weak var nameEntryLabel: UILabel!
    @IBOutlet weak var nameEntryBox: UITextField!
   
    var namesEntered = 0
    var player = 1
    var nameEntryComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(myGame.numPlayers)
        playerNamePrompt.text = "Let's get the names of those \(myGame.numPlayers) players:"
        playerNamePrompt.textColor = UIColor.blue
       
        nameEntryLabel.text = "Enter player \(player)'s name:"

   }
    
    
    @IBAction func playerSubmission(_ sender: Any) {
        
        if nameEntryBox.text == "" {
            
            showAlertButtonTapped()
        
        } else {
            
            var nextPlayer: Player = Player(name: String(nameEntryBox.text!))
            myGame.currPlayers.append(nextPlayer)
            
            nameEntryBox.text = ""
            namesEntered += 1
            
            nameEntryLabel.text = "Enter player \(player + namesEntered)'s name:"
            print(myGame.currPlayers.count)
        }
        
        if namesEntered == myGame.numPlayers {
            print("All names received.")
            performSegue(withIdentifier: "nameConfirmation", sender: sender)
        }
    }
    
    func showAlertButtonTapped(){
        let alert = UIAlertController(title: "You didn't enter a name!",  message: "Please enter a name before submitting.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
   }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

