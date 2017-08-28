//
//  BidEntryViewController.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/21/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit



var currBtnPos = 150
var currSliderPos = 130
var bidingPlayer = Game.myGame.firstBid

//button array
var btnArr = [String: UIButton]()

//slider array
var sliderArr = [String: UISlider]()

//uilabel array
var labelArr = [String: UILabel]()



class BidEntryViewController: UIViewController {

    @IBOutlet weak var currRoundDisplay: UILabel!
    @IBOutlet weak var roundProgressBar: UIProgressView!
    @IBOutlet weak var cardCountDisplay: UILabel!
    @IBOutlet weak var dealerDisplay: UILabel!
    @IBOutlet weak var beginHandBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
        roundProgressBar.setProgress(Float(Game.myGame.currRound) / Float(Game.myGame.numRounds), animated: true)
        roundProgressBar.progressTintColor = colorScheme.apricot
        roundProgressBar.trackTintColor = colorScheme.blueberry
        
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
            dynamicBtn.setTitle("Enter bid for \(Game.myGame.currPlayers[bidingPlayer].name)", for: UIControlState.normal)
            dynamicBtn.frame = CGRect(x: 62, y: currBtnPos, width: 250, height: 25)
            dynamicBtn.tag = bidingPlayer + Game.myGame.numPlayers
            dynamicBtn.setTitleColor(colorScheme.blueberry, for: .normal)
            dynamicBtn.setTitleColor(colorScheme.apricot, for: .highlighted)
            print("Biding player btn: \(dynamicBtn.tag)")
            //register action on change event
            dynamicBtn.addTarget(self, action:#selector(commitPlayerBid), for: .touchUpInside)
            
            //add UIButton to view
            self.view.addSubview(dynamicBtn)
            
            //push to array for future use
            btnArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicBtn
            
            let dynamicSlider = UISlider()
            
            dynamicSlider.setValue(Float(0), animated: true)
            dynamicSlider.minimumValue = 0
            dynamicSlider.maximumValue = Float(Game.myGame.currRound)
            dynamicSlider.isContinuous = true
            dynamicSlider.tag = bidingPlayer
            dynamicSlider.frame = CGRect(x: 62, y: currSliderPos, width: 251, height: 25)
            dynamicSlider.minimumTrackTintColor = colorScheme.appleCore
            dynamicSlider.maximumTrackTintColor = colorScheme.blueberry
            print("dyn slider: \(dynamicSlider.tag)")
            
            //register action on change event
            dynamicSlider.addTarget(self, action:#selector(changedSliderValue), for: .valueChanged)
            
            //add UISlider to view
            self.view.addSubview(dynamicSlider)

            //push to array for future use
            sliderArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicSlider
            
            let dynamicText = UILabel()
            
            dynamicText.frame = CGRect(x: 325, y: currSliderPos, width: 50, height: 25)
            dynamicText.tag = bidingPlayer + (Game.myGame.numPlayers * 2)
            dynamicText.textColor = colorScheme.appleCore
            dynamicText.text = String(0)
            print("dyn text: \(dynamicText.tag)")
            
            //add UILabel to view
            self.view.addSubview(dynamicText)
            
            //push to array for future use
            labelArr[Game.myGame.currPlayers[bidingPlayer].name] = dynamicText
            
            //advance button location and player bidding
            currBtnPos += 65
            currSliderPos += 65
            bidingPlayer += 1
            
            if bidingPlayer >= Game.myGame.numPlayers {
                bidingPlayer = 0
            }
            

        }

        
        
    }
    
    func commitPlayerBid(sender: UIButton) {
       
        let btnTag = sender.tag % Game.myGame.numPlayers
        
        let associatedSlider = sliderArr["\(Game.myGame.currPlayers[btnTag].name)"]!
        
        print("The current overall round is \(Game.myGame.overallRound), modifying array at index \(Game.myGame.overallRound - 1), now with a count of: \(Game.myGame.currPlayers[btnTag].bid.count)")
        
        //if the player has not yet submitted a bid for this round append to bid array
        if (Game.myGame.currPlayers[btnTag].bid.count < Game.myGame.overallRound) {
            
            Game.myGame.currPlayers[btnTag].bid.append((Int)(associatedSlider.value))
        
        //otherwise, must be bid correction, overwrite old bid value with new
        } else if (Game.myGame.currPlayers[btnTag].bid.count == Game.myGame.overallRound) {
            
            Game.myGame.currPlayers[btnTag].bid[Game.myGame.overallRound - 1] = ((Int)(associatedSlider.value))
        
        }
        print("Bid for player: \(Game.myGame.currPlayers[btnTag].name) set as: \(Game.myGame.currPlayers[btnTag].getBid())")
    }
    
    func changedSliderValue(sender: UISlider) {
        
        let num = Int(sender.value)
        let sliderTag = sender.tag
        
        let associatedLabel = labelArr["\(Game.myGame.currPlayers[sliderTag].name)"]!
        
        
        associatedLabel.text = "\(num)"
        
    }
    

    @IBAction func verifyBidsComplete(_ sender: Any) {
        
        var bidsComplete = true
        
        for index in 0...Game.myGame.numPlayers - 1 {
            
            print("in for loop with count: \(Game.myGame.currPlayers[index].bid.count) and overall round: \(Game.myGame.overallRound)")
            if Game.myGame.currPlayers[index].bid.count != Game.myGame.overallRound {
                print("In if loop")
                showIncompleteBidAlert(player: Game.myGame.currPlayers[index].name)
                bidsComplete = false
            }
        }
        
        if bidsComplete && getRoundBidCount() == Game.myGame.invalidTotalBidCount {
            
            //notify user of invalid bid count
            let notifyInvalidBidCount = UIAlertController(title: "The total bid count is not allowed. There are \(Game.myGame.invalidTotalBidCount) tricks this round and currently the same number of bids.", message: "Please change the final bidder's bid.", preferredStyle: UIAlertControllerStyle.alert)
            
            notifyInvalidBidCount.addAction(UIAlertAction(title: "Will do!", style: UIAlertActionStyle.default, handler: nil))
            
            present(notifyInvalidBidCount, animated: true, completion: nil)
        }
        
        if bidsComplete {
            currBtnPos = 150
            currSliderPos = 130
            performSegue(withIdentifier: "playRound", sender: sender)
        }
        
        
    }
    
    func getRoundBidCount() -> Int {
        
        var roundBidCount: Int = 0
        
        for index in 0...Game.myGame.numPlayers - 1 {
            roundBidCount += Game.myGame.currPlayers[index].getBid()
        }
        
        return roundBidCount
    }
    
    func showIncompleteBidAlert(player: String){
        let alert = UIAlertController(title: "You didn't enter a bid for \(player)",  message: "Please submit a bid before beginning the round.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setBid(sender:UIButton!) {
        Game.myGame.currPlayers[bidingPlayer].bid.append(Int(currRoundDisplay.text!)!)
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
