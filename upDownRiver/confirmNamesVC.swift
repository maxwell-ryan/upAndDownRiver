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
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTable.center.x -= view.bounds.width
        continueBtn.center.x -= view.bounds.width
        
        nameTable.textColor = colorScheme.citrus
        var player = 1
        
        for name in Game.myGame.currPlayers {
            print("\(name.name)")
            nameTable.text?.append("\(name.icon) \(name.name) is ready!\n")
            player += 1
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //animate view subviews with duration expressed in seconds
        UIView.animate(withDuration: 0.5) {
            
            self.nameTable.center.x += self.view.bounds.width
            //self.continueBtn.center.y -= self.view.bounds.height
        }
        
        UIView.animate(withDuration: 1) {
            
            //self.nameTable.center.x += self.view.bounds.width
            self.continueBtn.center.x += self.view.bounds.width
        }

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showStats(_ sender: Any) {
        nameTable.text = ""
        performSegue(withIdentifier: "getBids", sender: sender)
    }


    



}
