//
//  playerNameScreenViewController.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/20/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class playerNameScreenViewController: UIViewController {
    

    @IBOutlet weak var nameEntryLabel: UILabel!
    @IBOutlet weak var nameEntryBox: UITextField!
    @IBOutlet weak var iconSelector: UISlider!
    @IBOutlet weak var iconDisplay: UILabel!
   
    var namesEntered = 0
    var player = 1
    var nameEntryComplete = false
    
    var icons = ["😀","😃","😄","😁","🤠","🤡","🤑","😱","👻","👽","🎅","👨‍🚀", "😂", "💪", "😂", "😜", "🙈", "🐧", "🐔"]
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        print(Game.myGame.numPlayers)
       
       
        nameEntryLabel.textColor = colorScheme.apricot
        

        
        iconDisplay.text = icons[0]
        iconSelector.isContinuous = true
        iconSelector.maximumValue = Float(icons.count - 1)
        iconSelector.minimumValue = 0.0
        iconSelector.thumbTintColor = colorScheme.blueberry
        iconSelector.maximumTrackTintColor = colorScheme.appleCore
        iconSelector.minimumTrackTintColor = colorScheme.appleCore
        iconSelector.value = 0
        iconSelector.addTarget(self, action: #selector(changeIcon), for: .valueChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        iconSelector.center.x += view.bounds.width
        iconDisplay.center.x += view.bounds.width
        
        if nameEntryComplete == false {
            nameEntryLabel.text = "Enter player \(player)'s name and select a icon"
        } else {
            nameEntryLabel.text = "Please change or re-confirm player \(player)"
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5) {
            self.iconSelector.center.x -= self.view.bounds.width
            self.iconDisplay.center.x -= self.view.bounds.width
        }
    }
    
    func changeIcon(sender: UISlider) {
        
        var selection = Int(sender.value)
        iconDisplay.text = icons[selection]
        
    }
    
    @IBAction func playerSubmission(_ sender: Any) {
        
        if nameEntryBox.text == "" {
            
            showAlertButtonTapped()
        
        } else if nameEntryComplete == false {
            
            var nextPlayer: Player = Player(name: String(nameEntryBox.text!))
            
            if iconDisplay.text != nil {
                nextPlayer.icon = iconDisplay.text!
            }
            
            Game.myGame.currPlayers.append(nextPlayer)
            
            iconSelector.value = 0
            iconDisplay.text = icons[0]
            nameEntryBox.text = ""
            namesEntered += 1
            
            nameEntryLabel.text = "Enter player \(player + namesEntered)'s name and select an icon:"
            print(Game.myGame.currPlayers.count)
            
            if namesEntered == Game.myGame.numPlayers {
                
                print("All names received.")
                nameEntryComplete = true
                namesEntered = 0
                player = 1
                performSegue(withIdentifier: "nameConfirmation", sender: sender)
            }
            
        } else if nameEntryComplete == true {
            
            var existingPlayer = Game.myGame.currPlayers[namesEntered]
            
            existingPlayer.name = String(nameEntryBox.text!)
            
            if iconDisplay.text != nil {
                existingPlayer.icon = iconDisplay.text!
            }
            
            iconSelector.value = 0
            iconDisplay.text = icons[0]
            nameEntryBox.text = ""
            namesEntered += 1
            
            nameEntryLabel.text = "Enter player \(player + namesEntered)'s name and select an icon:"
            print(Game.myGame.currPlayers.count)
            
            if namesEntered == Game.myGame.numPlayers {
                
                print("All names received.")
                namesEntered = 0
                player = 1
                performSegue(withIdentifier: "nameConfirmation", sender: sender)
            }
            
            
            
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

