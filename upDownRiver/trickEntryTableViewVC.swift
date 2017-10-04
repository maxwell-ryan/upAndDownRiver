//
//  trickEntryTableViewVC.swift
//  upDownRiver
//
//  Created by maxwell on 8/29/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit


class trickEntryTableViewVC: UITableViewController {
    
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet var trickTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add padding so table view doesn't overlap status bar at top (LTE, reception bars, etc.)
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Trick Entry"
        } else {
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let height: CGFloat
        
        if section == 0 {
            height = 35.0
        } else {
            height = 0.0
        }
        
        return height
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) {
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
            returnedView.backgroundColor = .white
            
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: view.frame.size.width, height: 25))
            
            if section == 1 {
                label.text = ""
            } else {
                label.text = "Trick Entry"
            }
            
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor = colorScheme.blueberry
            label.backgroundColor = .white
            
            returnedView.addSubview(label)
            
            return returnedView
        } else {
            return nil
        }
        
    }

    @IBAction func completeTrickEntry(_ sender: Any) {
        //let bidTable = self.tableView.visibleCells as! Array<bidEntryTableViewCell>
        
        var cellArray = Array<bidTrickEntryTableViewCell>()
        let section = 1
        
        for row in 0 ..< tableView.numberOfRows(inSection: section) {
            let currentCell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! bidTrickEntryTableViewCell
            cellArray.append(currentCell)
        }
        
        for cell in cellArray {
            cell.bidSlider.sendActions(for: .valueChanged)
        }
        
        let totalTrickCount = getRoundTrickCount()
        
        if (totalTrickCount != Game.myGame.invalidTotalBidCount) {
            
            showInvalidTrickCountAlert()
            
        } else {
            
            confirmTricksAlert()
        }
    }

    func changedSliderValue(sender: UISlider) {
        
        //get value from sending slider - cast to int to round off decimal point values
        let value = Int(sender.value)
        
        //get offset of firstBid to number of players
        let offset = Game.myGame.numPlayers - Game.myGame.firstBid
        
        //associated table view row using offset and mod # players for array index wrap around
        let row = (sender.tag + offset) % Game.myGame.numPlayers
        
        //get the cell associated with the slider whose state changed
        let cell = trickTableView.cellForRow(at: NSIndexPath(row: row, section: 1) as IndexPath) as! bidTrickEntryTableViewCell
        
        cell.bidDisplay.text = "\(value)"
        
        let currentPlayer = Game.myGame.currPlayers[sender.tag]
        print("Tag: \(sender.tag)")
        print("The current overall round is \(Game.myGame.overallRound), changes for player: \(currentPlayer.name) modifying array at index \(Game.myGame.overallRound - 1), now with a count of: \(currentPlayer.trick.count)")
        
        //if the player has not yet submitted a bid for this round append to bid array
        if (currentPlayer.trick.count < Game.myGame.overallRound) {
            
            currentPlayer.trick.append(value)
            
            //otherwise, must be bid correction, overwrite old bid value with new
        } else if (Game.myGame.currPlayers[sender.tag].trick.count == Game.myGame.overallRound) {
            
            currentPlayer.trick[Game.myGame.overallRound - 1] = (value)
            
        }
        
        //using trick count just entered, calcuate round score
        Game.myGame.currPlayers[sender.tag].calculateRoundScore()
        
        print("Trick for player: \(currentPlayer.name) set as: \(currentPlayer.getTrick())")
    }

    func getRoundTrickCount() -> Int {
        
        var roundTrickCount: Int = 0
        
        for index in 0...Game.myGame.numPlayers - 1 {
            roundTrickCount += Game.myGame.currPlayers[index].getTrick()
        }
        
        return roundTrickCount
    }

    func showInvalidTrickCountAlert(){
        let notifyInvalidBidCount = UIAlertController(title: "The total tricks entered do not add up to \(Game.myGame.currRound).", message: "Please double check all trick counts entered.", preferredStyle: UIAlertControllerStyle.alert)
        
        notifyInvalidBidCount.addAction(UIAlertAction(title: "Will do!", style: UIAlertActionStyle.default, handler: nil))
        
        present(notifyInvalidBidCount, animated: true, completion: nil)
    }

    func confirmTricksAlert() {
        
        var trickSummary = "\n"
        
        for player in Game.myGame.currPlayers {
            trickSummary.append(player.name + ": \(player.getTrick())\n")
        }
        
        let confirmTricksAlert = UIAlertController(title: "Confirm round tricks", message: trickSummary, preferredStyle: UIAlertControllerStyle.alert)
        
        let confirmTricksAction = UIAlertAction(title: "Tricks are accurate", style: .default) { (action) in self.performSegue(withIdentifier: "viewRoundStats", sender: self)}
        
        let changeTricksAction = UIAlertAction(title: "Let me change tricks entered", style: .destructive, handler: nil)
        
        confirmTricksAlert.addAction(confirmTricksAction)
        confirmTricksAlert.addAction(changeTricksAction)
        
        present(confirmTricksAlert, animated: true, completion: nil)
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //simple one section tableView
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return Game.myGame.currPlayers.count;
        }
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerCellHeight: CGFloat = 90
        let bodyCellHeight: CGFloat = 50
        
        if indexPath.section == 0 {
            return headerCellHeight
            
        } else {
            return bodyCellHeight
        }
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = trickTableView.dequeueReusableCell(withIdentifier: "bidCell", for: indexPath) as! bidTrickEntryTableViewCell
            
            let currentPlayer = ((Game.myGame.firstBid + indexPath.row) % Game.myGame.numPlayers)
            
            cell.bidSlider.maximumValue = Float(Game.myGame.currRound)
            cell.bidSlider.minimumValue = 0
            cell.bidSlider.setValue(Float(Game.myGame.currPlayers[currentPlayer].getBid()), animated: true)
            cell.bidSlider.isContinuous = true
            cell.bidSlider.thumbTintColor = colorScheme.blueberry
            cell.bidSlider.minimumTrackTintColor = colorScheme.appleCore
            cell.bidSlider.maximumTrackTintColor = colorScheme.blueberry
            cell.bidSlider.tag = currentPlayer
            cell.bidSlider.addTarget(self, action: #selector(changedSliderValue), for: .valueChanged)
            
            
            cell.bidDisplay.textColor = colorScheme.blueberry
            cell.bidDisplay.text = String(Game.myGame.currPlayers[currentPlayer].getBid())
            
            cell.nameDisplay.textColor = colorScheme.blueberry
            
            switch indexPath.row {
            case 0:
                cell.nameDisplay.text = Game.myGame.currPlayers[Game.myGame.firstBid].name
            default:
                cell.nameDisplay.text = Game.myGame.currPlayers[currentPlayer].name
            }
            
            return cell
            
        } else {
            let cell = trickTableView.dequeueReusableCell(withIdentifier: "bidHeaderCell", for: indexPath) as! headerTableViewCell
            
            cell.dealerDisplay.text = "Dealer: \(Game.myGame.currPlayers[Game.myGame.currDealer].icon) \(Game.myGame.currPlayers[Game.myGame.currDealer].name)"
            cell.dealerDisplay.textColor = colorScheme.appleCore
            
            cell.cardCountDisplay.text = "Cards: \(Game.myGame.currRound)"
            cell.cardCountDisplay.textColor = colorScheme.appleCore
            
            cell.roundDisplay.text = "Round: \(Game.myGame.overallRound) of \(Game.myGame.numRounds)"
            cell.roundDisplay.textColor = colorScheme.blueberry
            cell.roundDisplay.font = UIFont.boldSystemFont(ofSize: 15)
            
            cell.roundProgressDisplay.setProgress(Float(Game.myGame.overallRound) / Float(Game.myGame.numRounds), animated: true)
            cell.roundProgressDisplay.progressTintColor = colorScheme.apricot
            cell.roundProgressDisplay.trackTintColor = colorScheme.blueberry
            
            
            return cell
        }
    }
}
