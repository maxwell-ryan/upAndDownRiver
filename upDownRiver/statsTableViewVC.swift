//
//  StatsTableViewController.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/21/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {

    @IBOutlet var statsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //add padding so table view doesn't overlap status bar at top (LTE, reception bars, etc.)
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statsView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Scoreboard"
        } else {
            return ""
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //simple one section tableView
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return Game.myGame.currPlayers.count
        } else {
            return 0;
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentPlayer = Game.myGame.currPlayers[indexPath.row]
        
        let cell = statsView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! statsTableViewCell

        cell.nameDisplay.text = "\(currentPlayer.icon) \(currentPlayer.name)"
        cell.scoreDisplay.text = String(currentPlayer.getOverallScore())
        //cell.currentSteakDisplay.text = "Current Streak: \(currentPlayer.getCurrentStreak())"
        //cell.longestStreakDisplay.text = "Longest Steak: \(currentPlayer.getLongestStreak())"
        cell.currentSteakDisplay.text = "Current streak: \(currentPlayer.getCurrentStreak())"
        cell.longestStreakDisplay.text = "Longest streak: \(currentPlayer.getLongestStreak())"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
