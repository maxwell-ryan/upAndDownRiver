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
var bidingPlayer = myGame.firstBid

//button array
var btnArr = [UIButton]()

//slider array
var sliderArr = [UISlider]()

//uilabel array
var labelArr = [UILabel]()

class BidEntryViewController: UIViewController {

    @IBOutlet weak var currRoundDisplay: UILabel!
    @IBOutlet weak var roundProgressBar: UIProgressView!
    @IBOutlet weak var cardCountDisplay: UILabel!
    @IBOutlet weak var dealerDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        roundProgressBar.setProgress(Float(myGame.currRound) / Float(myGame.numRounds), animated: true)
        
        currRoundDisplay.textColor = UIColor.green
        currRoundDisplay.text = "Round \(myGame.currRound)"
        cardCountDisplay.text = "Cards this round: \(myGame.currRound)"
        
        dealerDisplay.text = "Dealt by: \(myGame.currPlayers[myGame.currDealer].name)"
        
        if bidingPlayer >= myGame.numPlayers {
            bidingPlayer = 0
        }
        
        for index in 0...myGame.numPlayers - 1 {
            
            print("Biding player btn: \(bidingPlayer)")
            let dynamicBtn = UIButton(type: UIButtonType.system)
            
            dynamicBtn.adjustsImageWhenHighlighted = true
            dynamicBtn.setTitle("Enter bid for \(myGame.currPlayers[bidingPlayer].name)", for: UIControlState.normal)
            dynamicBtn.frame = CGRect(x: 62, y: currBtnPos, width: 250, height: 25)
            dynamicBtn.tag = bidingPlayer
            
            //add UIButton to view
            self.view.addSubview(dynamicBtn)
            
            //push to array for future use
            btnArr.append(dynamicBtn)
            
            let dynamicSlider = UISlider()
            
            dynamicSlider.setValue(Float(myGame.currRound), animated: true)
            dynamicSlider.minimumValue = 0
            dynamicSlider.maximumValue = Float(myGame.currRound)
            dynamicSlider.isContinuous = true
            dynamicSlider.tag = bidingPlayer + myGame.numPlayers
            dynamicSlider.frame = CGRect(x: 62, y: currSliderPos, width: 251, height: 25)
            dynamicSlider.minimumTrackTintColor = UIColor.green
            dynamicSlider.maximumTrackTintColor = UIColor.red
            print("dyn slider: \(dynamicSlider.tag)")
            //register action on change event
            dynamicSlider.addTarget(self, action:#selector(changedSliderValue), for: .valueChanged)
            
            //add UISlider to view
            self.view.addSubview(dynamicSlider)

            //push to array for future use
            sliderArr.append(dynamicSlider)
            
            let dynamicText = UILabel()
            
            dynamicText.frame = CGRect(x: 325, y: currSliderPos, width: 50, height: 25)
            dynamicText.tag = bidingPlayer + (myGame.numPlayers * 2)
            dynamicText.text = String(bidingPlayer + 8)
            print("dyn text: \(dynamicText.tag)")
            //add UILabel to view
            self.view.addSubview(dynamicText)
            
            //push to array for future use
            labelArr.append(dynamicText)
            
            //advance button location and player bidding
            currBtnPos += 65
            currSliderPos += 65
            bidingPlayer += 1
            
            if bidingPlayer >= myGame.numPlayers {
                bidingPlayer = 0
            }
            

        }

        
        
    }
    
    func changedSliderValue(sender: UISlider) {
        
        let num = Int(sender.value)
        
        var labelIdx = sender.tag - (myGame.numPlayers + 1)
        if labelIdx < 0 {
            labelIdx = myGame.numPlayers - 1
        }
        
        let assoicatedLabel = labelArr[labelIdx]
        
        assoicatedLabel.text = "\(num)"
        
    }
    
    func setBid(sender:UIButton!) {
        myGame.currPlayers[bidingPlayer].bid.append(Int(currRoundDisplay.text!)!)
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
