//
//  player.swift
//  upDownRiver
//
//  Created by bergerMacPro on 6/21/17.
//  Copyright © 2017 bergerMacPro. All rights reserved.
//

import Foundation
import UIKit

class Player {
    
    let name: String
    
    var score = [Int]()
    var bid = [Int]()
    var trick = [Int]()
    
    init(name: String) {
        self.name = name
        score.append(0)
        bid.append(0)
        trick.append(0)
    }
    
    func getScore() -> Int {
        return score.last!
    }
    
    func getBid() -> Int {
        return bid.last!
    }
    
    func getTrick() -> Int {
        return trick.last!
    }
    
    
}

class Game {
    
    var numPlayers: Int
    var numRounds: Int {
        return (52 / numPlayers) * 2 - 1
    }
   
    var currRound: Int
    var overallRound: Int
    
    var currDealer: Int
    var firstBid: Int
    
    var upRiver: Bool
    var gameOver: Bool
    
    var currPlayers: [Player] = []
    
    init(numPlayers: Int){
        self.numPlayers = numPlayers
        self.currRound = 1
        self.overallRound = 1
        self.currDealer = 0
        self.firstBid = 1
        self.upRiver = true
        self.gameOver = false
    }
    
    func advanceDeal() {
        self.firstBid += 1
        if firstBid >= numPlayers {
            firstBid = 0
        }
        self.currDealer += 1
        if currDealer >= numPlayers {
            currDealer = 0
        }
    }
    
    func advanceRound() {
        
        if ((currRound + 1) < (52 / numPlayers)) {
            
            currRound += 1
            overallRound += 1
        
        } else if ((currRound + 1) == (52 / numPlayers)) {
            
            currRound += 1
            upRiver = false
            overallRound += 1
        
        } else if (overallRound < numRounds) {
            
            currRound -= 1
            overallRound += 1
            
        } else if (overallRound == numRounds) {
            
            gameOver = true
        }
    }
    
}
