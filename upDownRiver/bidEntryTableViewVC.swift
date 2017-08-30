//
//  bidEntryTableViewVC.swift
//  upDownRiver
//
//  Created by maxwell on 8/26/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit

class bidEntryTableViewVC: UITableViewController {
    
    @IBOutlet weak var beginHandBtn: UIButton!
    @IBOutlet var bidTableView: UITableView!
    
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
            return "Bid Entry"
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
                label.text = "Bid Entry"
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
    
    @IBAction func completeBidEntry(_ sender: Any) {
        
        //let bidTable = self.tableView.visibleCells as! Array<bidTrickEntryTableViewCell>

        var cellArray = Array<bidTrickEntryTableViewCell>()
        let section = 1

        for row in 0 ..< tableView.numberOfRows(inSection: section) {
            let currentCell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! bidTrickEntryTableViewCell
            cellArray.append(currentCell)
        }
        
        for cell in cellArray {
            cell.bidSlider.sendActions(for: .valueChanged)
        }
        
        let totalBidCount = getRoundBidCount()
        
        if (totalBidCount == Game.myGame.invalidTotalBidCount) {
            
            showIncompleteBidAlert(player: Game.myGame.currPlayers[Game.myGame.currDealer].name)
        
        } else {
           
            confirmBidsAlert()
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
        let cell = bidTableView.cellForRow(at: NSIndexPath(row: row, section: 1) as IndexPath) as! bidTrickEntryTableViewCell
        
        cell.bidDisplay.text = "\(value)"
        
        let currentPlayer = Game.myGame.currPlayers[sender.tag]
        print("Tag: \(sender.tag)")
        print("The current overall round is \(Game.myGame.overallRound), changes for player: \(currentPlayer.name) modifying array at index \(Game.myGame.overallRound - 1), now with a count of: \(currentPlayer.bid.count)")
        
        //if the player has not yet submitted a bid for this round append to bid array
        if (currentPlayer.bid.count < Game.myGame.overallRound) {
            
            currentPlayer.bid.append(value)
            
            //otherwise, must be bid correction, overwrite old bid value with new
        } else if (Game.myGame.currPlayers[sender.tag].bid.count == Game.myGame.overallRound) {
            
            currentPlayer.bid[Game.myGame.overallRound - 1] = (value)
            
        }
        print("Bid for player: \(currentPlayer.name) set as: \(currentPlayer.getBid())")
    }
    
    func getRoundBidCount() -> Int {
        
        var roundBidCount: Int = 0
        
        for index in 0...Game.myGame.numPlayers - 1 {
            roundBidCount += Game.myGame.currPlayers[index].getBid()
        }
        
        return roundBidCount
    }
    
    func showIncompleteBidAlert(player: String){
        let notifyInvalidBidCount = UIAlertController(title: "The total bid count is not allowed. There are \(Game.myGame.invalidTotalBidCount) tricks this round and currently the same number of bids.", message: "Please change \(player)'s bid.", preferredStyle: UIAlertControllerStyle.alert)
        
        notifyInvalidBidCount.addAction(UIAlertAction(title: "Will do!", style: UIAlertActionStyle.default, handler: nil))
        
        present(notifyInvalidBidCount, animated: true, completion: nil)
    }
    
    func confirmBidsAlert() {
        
        var bidSummary = "\n"
        
        for player in Game.myGame.currPlayers {
            bidSummary.append(player.name + ": \(player.getBid())\n")
        }
        
        let confirmBidsAlert = UIAlertController(title: "Confirm round bids", message: bidSummary, preferredStyle: UIAlertControllerStyle.alert)
        let confirmBidsAction = UIAlertAction(title: "Bids are accurate", style: .default) { (action) in self.performSegue(withIdentifier: "playRound", sender: self)}
        
        let changeBidsAction = UIAlertAction(title: "Let me change bid(s)", style: .destructive, handler: nil)
        
        confirmBidsAlert.addAction(confirmBidsAction)
        confirmBidsAlert.addAction(changeBidsAction)
        
        present(confirmBidsAlert, animated: true, completion: nil)
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
            let cell = bidTableView.dequeueReusableCell(withIdentifier: "bidCell", for: indexPath) as! bidTrickEntryTableViewCell
            
            let currentPlayer = ((Game.myGame.firstBid + indexPath.row) % Game.myGame.numPlayers)
            
            cell.bidSlider.maximumValue = Float(Game.myGame.currRound)
            cell.bidSlider.minimumValue = 0
            cell.bidSlider.setValue(Float(Game.myGame.currRound), animated: true)
            cell.bidSlider.isContinuous = true
            cell.bidSlider.thumbTintColor = colorScheme.blueberry
            cell.bidSlider.minimumTrackTintColor = colorScheme.appleCore
            cell.bidSlider.maximumTrackTintColor = colorScheme.blueberry
            cell.bidSlider.tag = currentPlayer
            cell.bidSlider.addTarget(self, action: #selector(changedSliderValue), for: .valueChanged)
            
            
            cell.bidDisplay.textColor = colorScheme.blueberry
            cell.bidDisplay.text = String(Game.myGame.currRound)
            
            cell.nameDisplay.textColor = colorScheme.blueberry
            
            switch indexPath.row {
            case 0:
                cell.nameDisplay.text = Game.myGame.currPlayers[Game.myGame.firstBid].name
            default:
                cell.nameDisplay.text = Game.myGame.currPlayers[currentPlayer].name
            }
            
            return cell
            
        } else {
            let cell = bidTableView.dequeueReusableCell(withIdentifier: "bidHeaderCell", for: indexPath) as! headerTableViewCell

            cell.dealerDisplay.text = "Dealer: \(Game.myGame.currPlayers[Game.myGame.currDealer].icon) \(Game.myGame.currPlayers[Game.myGame.currDealer].name)"
            cell.dealerDisplay.textColor = colorScheme.appleCore
            
            cell.cardCountDisplay.text = "Cards: \(Game.myGame.currRound)"
            cell.cardCountDisplay.textColor = colorScheme.appleCore
            
            cell.roundDisplay.text = "Round: \(Game.myGame.currRound)"
            cell.roundDisplay.textColor = colorScheme.blueberry
            cell.roundDisplay.font = UIFont.boldSystemFont(ofSize: 15)
            
            cell.roundProgressDisplay.setProgress(Float(Game.myGame.currRound) / Float(Game.myGame.numRounds), animated: true)
            cell.roundProgressDisplay.progressTintColor = colorScheme.apricot
            cell.roundProgressDisplay.trackTintColor = colorScheme.blueberry
            
            
            return cell
        }
    }
}
