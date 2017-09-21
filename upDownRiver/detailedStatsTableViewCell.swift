//
//  detailedStatsTableViewCell.swift
//  upDownRiver
//
//  Created by bergerMacPro on 9/19/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class detailedStatsTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!

}
    
extension detailedStatsTableViewCell {
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        //collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
}


//extension detailedStatsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
//      
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Game.myGame.overallRound;
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let frameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "frameCell", for: indexPath) as! frameStatsCollectionViewCell
//      
//        
//        return frameCell
//    }
//}
