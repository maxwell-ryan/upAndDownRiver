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
    var icon: String
    var currentScore: Int
    var currentStreak: Int
    var previousRoundStreak: Int
    var longestStreak: Int
    
    var score = [Int]()
    var bid = [Int]()
    var trick = [Int]()
    
    init(name: String) {
        
        self.name = name
        self.currentScore = 0
        self.currentStreak = 0
        self.previousRoundStreak = 0
        self.longestStreak = 0
        self.icon = ""
        
        //score.append(0)
        //bid.append(0)
        //trick.append(0)
    }
    
    func getCurrentStreak() -> Int {
        return currentStreak
    }
    
    func getLongestStreak() -> Int {
        return longestStreak
    }
    func getOverallScore() -> Int {
        return currentScore
    }
    
    func getRoundScore() -> Int {
        return score.last!
    }
    
    func getBid() -> Int {
        return bid.last!
    }
    
    func getTrick() -> Int {
        return trick.last!
    }
    
    func getAvgBid() -> Double {
        var avg_sum = 0
        var average: Double
        
        for bid in bid {
            avg_sum += bid
        }
        
        average = Double(avg_sum / bid.count)
        
        return average
    }
    
    func getAvgRealtiveBid() -> Double {
        
        let bidCount: Int = bid.count
        var relativeSum = 0.0
        
        for x in 0...(bidCount - 1) {
            relativeSum += Double(bid[x] - (x + 1))
        }
        
        return (relativeSum / Double(bidCount))
    }
    
    func calculateRoundScore() {
        
        let lastBid = getBid()
        let lastTrick = getTrick()
        
        if (score.count < bid.count) {
            
            if (lastBid == lastTrick) {
                
                //current round score for making bid is 10 + num. of tricks taken in round
                score.append(10 + lastTrick)
                
                //increment the user's current streak
                previousRoundStreak = currentStreak
                currentStreak = previousRoundStreak + 1
                
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                
                //debug output
                print("Score count now: \(score.count) with latest score: \(score.last!)")
                
            } else {
                
                //if bid missed, round score = num. of tricks taken in round
                score.append(lastTrick)
                
                //reset the user's current streak
                previousRoundStreak = currentStreak
                currentStreak = 0
                
                //debug output
                print("Score count now: \(score.count) with latest score: \(score.last!)")
            }
        
        //repeat above logic for score revisions - will only enter this block if user changing previous entry
        } else if (score.count == bid.count) {
            
            if (lastBid == lastTrick) {
                score[score.count - 1] = (10 + lastTrick)
                
                currentStreak = previousRoundStreak + 1
                
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                
                print("Score count now: \(score.count) with latest score: \(score.last!)")
            
            } else {
                score[score.count - 1] = (lastTrick)
                
                currentStreak = 0
                
                print("Score count now: \(score.count) with latest score: \(score.last!)")
            }
        }
        
        var total = 0
        let size = score.count
        for x in 0...(size - 1) {
            total += score[x]
        }
        
        currentScore = total
    }
    
    
}

class Game {
    
    static var myGame = Game(numPlayers: 2)
    
    var numPlayers: Int
    
    //defaults to max number of rounds possible with given player count
    var numRounds: Int {
        return (52 / numPlayers) * 2 - 1
    }
   
    var currRound: Int  //tracks the current round in relation to num cards that round
    var overallRound: Int   //tracks the overall round count - each currRound has 2 instances except top of river (apex)
    
    var currDealer: Int
    var firstBid: Int
    
    var upRiver: Bool
    var gameOver: Bool
    
    var currPlayers: [Player] = []
    
    var invalidTotalBidCount: Int {
        get {
            return currRound
        }
    }
    
    private init(numPlayers: Int){
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
        
        //advances round counts forward
        if ((currRound + 1) < (52 / numPlayers)) {
            
            currRound += 1
            overallRound += 1
        
        //advances round count forward and identifies top of river event
        } else if ((currRound + 1) == (52 / numPlayers)) {
            
            currRound += 1
            upRiver = false
            overallRound += 1
        
        //advances round after top of river event
        } else if (overallRound < numRounds) {
            
            currRound -= 1
            overallRound += 1
        
        //identifies end of game event - halts advancing rounds further on call
        } else if (overallRound == numRounds) {
            
            gameOver = true
        }
    }
    
}
