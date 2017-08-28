//
//  trickEntryVC.swift
//  upDownRiver
//
//  Created by maxwell on 7/19/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit

var currTrickBtnPos = 150
var currTrickSliderPos = 130
var currTrickBidingPlayer = Game.myGame.firstBid

//button array
var trickBtnArr = [String: UIButton]()

//slider array
var trickSliderArr = [String: UISlider]()

//uilabel array
var trickLabelArr = [String: UILabel]()

class TrickEntryViewController: UIViewController {
    
    
    //@IBOutlet weak var currRoundDisplay: UILabel!
    
    @IBOutlet weak var currRoundDisplay: UILabel!
    //@IBOutlet weak var roundProgressBar: UIProgressView!
    
    @IBOutlet weak var roundProgressBar: UIProgressView!
    //@IBOutlet weak var cardCountDisplay: UILabel!
    
    @IBOutlet weak var cardCountDisplay: UILabel!
    //@IBOutlet weak var dealerDisplay: UILabel!
    
    @IBOutlet weak var dealerDisplay: UILabel!
    
    //@IBOutlet weak var beginHandBtn: UIButton!
    
    @IBOutlet weak var advanceHandBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        roundProgressBar.progressTintColor = colorScheme.apricot
        roundProgressBar.trackTintColor = colorScheme.blueberry
        roundProgressBar.setProgress(Float(Game.myGame.currRound) / Float(Game.myGame.numRounds), animated: true)
        
        currRoundDisplay.textColor = colorScheme.blueberry
        currRoundDisplay.font = UIFont.boldSystemFont(ofSize: 15)
        currRoundDisplay.text = "Round \(Game.myGame.currRound)"
        
        cardCountDisplay.textColor = colorScheme.blueberry
        cardCountDisplay.text = "Cards this round: \(Game.myGame.currRound)"
        
        dealerDisplay.textColor = colorScheme.apricot
        dealerDisplay.text = "Dealt by: \(Game.myGame.currPlayers[Game.myGame.currDealer].name)"
        
        if bidingPlayer >= Game.myGame.numPlayers {
            bidingPlayer = 0
        }
        
        for index in 0...Game.myGame.numPlayers - 1 {
            
            let dynamicBtn = UIButton(type: UIButtonType.system)
            
            dynamicBtn.adjustsImageWhenHighlighted = true
            dynamicBtn.setTitle("Enter trick count for \(Game.myGame.currPlayers[bidingPlayer].name)", for: UIControlState.normal)
            dynamicBtn.frame = CGRect(x: 62, y: currTrickBtnPos, width: 250, height: 25)
            dynamicBtn.tag = bidingPlayer + Game.myGame.numPlayers
            dynamicBtn.setTitleColor(colorScheme.blueberry, for: .normal)
            dynamicBtn.setTitleColor(colorScheme.apricot, for: .highlighted)
            print("Tricking player btn: \(dynamicBtn.tag)")
            
            //register action on change event
            dynamicBtn.addTarget(self, action:#selector(commitPlayerTrick), for: .touchUpInside)
            
            //add UIButton to view
            self.view.addSubview(dynamicBtn)
            
            //push to array for future use
            trickBtnArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicBtn
            
            let dynamicSlider = UISlider()
            
            dynamicSlider.setValue(Float(0), animated: true)
            dynamicSlider.minimumValue = 0
            dynamicSlider.maximumValue = Float(Game.myGame.currRound)
            dynamicSlider.isContinuous = true
            dynamicSlider.tag = bidingPlayer
            dynamicSlider.frame = CGRect(x: 62, y: currTrickSliderPos, width: 251, height: 25)
            dynamicSlider.minimumTrackTintColor = colorScheme.appleCore
            dynamicSlider.maximumTrackTintColor = colorScheme.blueberry
            print("dyn slider: \(dynamicSlider.tag)")
            
            //register action on change event
            dynamicSlider.addTarget(self, action:#selector(changedSliderValue), for: .valueChanged)
            
            //add UISlider to view
            self.view.addSubview(dynamicSlider)
            
            //push to array for future use
            trickSliderArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicSlider
            
            let dynamicText = UILabel()
            
            dynamicText.frame = CGRect(x: 325, y: currTrickSliderPos, width: 50, height: 25)
            dynamicText.tag = bidingPlayer + (Game.myGame.numPlayers * 2)
            dynamicText.textColor = colorScheme.appleCore
            dynamicText.text = String(0)
            print("dyn text: \(dynamicText.tag)")
            
            //add UILabel to view
            self.view.addSubview(dynamicText)
            
            //push to array for future use
            trickLabelArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicText
            
            //advance button location and player bidding
            currTrickBtnPos += 65
            currTrickSliderPos += 65
            bidingPlayer += 1
            
            if bidingPlayer >= Game.myGame.numPlayers {
                bidingPlayer = 0
            }
            
            
        }
        
        
        
    }
    
    func commitPlayerTrick(sender: UIButton) {
        
        let btnTag = sender.tag % Game.myGame.numPlayers
        
        let associatedSlider = trickSliderArr["\(Game.myGame.currPlayers[btnTag].name)"]!
        
        
        if (Game.myGame.currPlayers[btnTag].trick.count < Game.myGame.overallRound) {
            print("Current trick count pre: \(Game.myGame.currPlayers[btnTag].trick.count) with slider value: \(associatedSlider.value)")
            
            Game.myGame.currPlayers[btnTag].trick.append((Int)(associatedSlider.value))
            
            print("Current trick count post: \(Game.myGame.currPlayers[btnTag].trick.count)")
        
        } else if (Game.myGame.currPlayers[btnTag].trick.count == Game.myGame.overallRound) {
            
            Game.myGame.currPlayers[btnTag].trick[Game.myGame.overallRound - 1] = ((Int)(associatedSlider.value))
        
        }
        
        Game.myGame.currPlayers[btnTag].calculateRoundScore()

        
        print("Trick for player: \(Game.myGame.currPlayers[btnTag].name) set as: \(Game.myGame.currPlayers[btnTag].getTrick())")
    }
    
    func changedSliderValue(sender: UISlider) {
        
        let num = Int(sender.value)
        let sliderTag = sender.tag
        
        var associatedLabel = trickLabelArr["\(Game.myGame.currPlayers[sliderTag].name)"]!
        
        
        associatedLabel.text = "\(num)"
        
    }
    
    
    @IBAction func verifyTricksComplete(_ sender: Any) {
        
        var tricksComplete = true
        
        for index in 0...Game.myGame.numPlayers - 1 {
            
            print("in for loop with count: \(Game.myGame.currPlayers[index].trick.count) and overall round: \(Game.myGame.overallRound)")
            if Game.myGame.currPlayers[index].trick.count != Game.myGame.overallRound {
                print("In if loop")
                showIncompleteBidAlert(player: Game.myGame.currPlayers[index].name)
                tricksComplete = false
            }
        }
        
        if tricksComplete && getRoundTrickCount() != Game.myGame.invalidTotalBidCount {
            
            //notify user of invalid bid count
            let notifyInvalidTrickCount = UIAlertController(title: "The total of player trick counts don't add to \(Game.myGame.invalidTotalBidCount) tricks.", message: "Please verify each player's trick count and resubmit, if needed.", preferredStyle: UIAlertControllerStyle.alert)
            
            notifyInvalidTrickCount.addAction(UIAlertAction(title: "Will do!", style: UIAlertActionStyle.default, handler: nil))
            
            present(notifyInvalidTrickCount, animated: true, completion: nil)
        }
        
        if tricksComplete {
            currTrickBtnPos = 150
            currTrickSliderPos = 130
            performSegue(withIdentifier: "viewRoundStats", sender: sender)
        }
        
    }
    
    func getRoundTrickCount() -> Int {
        
        var roundTrickCount: Int = 0
        
        for index in 0...Game.myGame.numPlayers - 1 {
            roundTrickCount += Game.myGame.currPlayers[index].getTrick()
        }
        
        return roundTrickCount
    }
    
    func showIncompleteBidAlert(player: String){
        let alert = UIAlertController(title: "You didn't enter a trick count for \(player)",  message: "Please submit their trick count before advancing to the next round.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTrick(sender:UIButton!) {
        Game.myGame.currPlayers[bidingPlayer].trick.append(Int(currRoundDisplay.text!)!)
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
