//
//  nameConfirmation.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/20/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import UIKit

class nameConfirmation: UIViewController {

    @IBOutlet weak var nameTable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for name in myGame.currPlayers {
            print("\(name)")
            nameTable.text?.append("\(name.name) is ready - current score: \(name.getScore())\n")
        }
        
    }

    @IBAction func showStats(_ sender: Any) {
        performSegue(withIdentifier: "stats", sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
