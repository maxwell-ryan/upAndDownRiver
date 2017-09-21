//
//  detailedStatsVC.swift
//  upDownRiver
//
//  Created by bergerMacPro on 9/19/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit


class DetailedStatsViewController: UITableViewController{
    
    
    @IBOutlet weak var nextRoundBtn: UIButton!
    
    @IBAction func nextRound(_ sender: Any) {
        
        if (Game.myGame.gameOver == false) {
            performSegue(withIdentifier: "advanceRound", sender: sender)
            Game.myGame.advanceDeal()
            Game.myGame.advanceRound()
        } else {
            performSegue(withIdentifier: "gameOver", sender: sender)
        }
    
    }

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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //each player receives his/her own row in detailed score tableView
        return Game.myGame.currPlayers.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        //each row labelled with that player's name
//        return Game.myGame.currPlayers[section].name + " | Current Score: " + String(Game.myGame.currPlayers[section].getOverallScore())
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: tableView.bounds.size.width - 10, height: 25))
        
        label.text = Game.myGame.currPlayers[section].icon + " " + Game.myGame.currPlayers[section].name + " | Current Score: " + String(Game.myGame.currPlayers[section].getOverallScore())
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = colorScheme.blueberry
        label.backgroundColor = .white
        
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //each player needs just a single row
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? detailedStatsTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let statsCell = tableView.dequeueReusableCell(withIdentifier: "detailedStatsCell") as! detailedStatsTableViewCell
        return statsCell
    }
}

extension DetailedStatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Game.myGame.overallRound
    }
    
    func collectionView (_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameCell", for: indexPath) as! frameStatsCollectionViewCell
        
        print(collectionView.tag)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = colorScheme.citrus.cgColor
        
        cell.bidFrameLabel.textColor = colorScheme.blueberry
        cell.trickFrameLabel.textColor = colorScheme.apricot
        cell.scoreFrameLabel.textColor = colorScheme.appleCore
        
        
        
        cell.roundFrameLabel.text = "Round: \(indexPath.item + 1)"
        cell.bidFrameLabel.text = String(Game.myGame.currPlayers[collectionView.tag].bid[indexPath.item])
        cell.trickFrameLabel.text = String(Game.myGame.currPlayers[collectionView.tag].trick[indexPath.item])
        cell.scoreFrameLabel.text = String(Game.myGame.currPlayers[collectionView.tag].score[indexPath.item])
        
        return cell
    }
    
}
