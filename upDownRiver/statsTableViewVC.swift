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
    @IBOutlet weak var advanceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        advanceButton.setTitle("Continue with hand", for: .normal)
        advanceButton.setTitle("Here we go...", for: .highlighted)
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
        return "Scoreboard"
    }

    @IBAction func enterBid(_ sender: Any) {
        performSegue(withIdentifier: "continueHand", sender: sender)
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
        
        let cell: UITableViewCell = statsView.dequeueReusableCell(withIdentifier: "prototype1", for: indexPath)


        cell.textLabel?.text = "\(Game.myGame.currPlayers[indexPath.row].icon) - \(Game.myGame.currPlayers[indexPath.row].name)"
        cell.detailTextLabel?.text = String(Game.myGame.currPlayers[indexPath.row].getOverallScore())

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
