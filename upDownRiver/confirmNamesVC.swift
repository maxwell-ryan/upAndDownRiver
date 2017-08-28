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
        
        nameTable.textColor = colorScheme.citrus
        var player = 1
        
        for name in Game.myGame.currPlayers {
            print("\(name.name)")
            nameTable.text?.append("\(name.icon), \(name.name), is ready!\n")
            player += 1
        }
        
    }

    @IBAction func showStats(_ sender: Any) {
        performSegue(withIdentifier: "getBids", sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
