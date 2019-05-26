//
//  ViewController.swift
//  Memorize
//
//  Created by Bram Anwar on 18/05/19.
//  Copyright © 2019 Bram Anwar. All rights reserved.
//

import UIKit
// Dekralarasi dulu
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 10 * 1000 // 10 Seconds
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
        cardArray = model.getCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Timer methods
    
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        //Convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //Set Label
        timerLabel.text = "Time Remaining: \(seconds)"
        
        //When timer reached 0
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //Check if there are any cards unmatched
            
        }
        
    }
    
    // MARK: - UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell" , for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            // Flip the card
            cell.flip()
            // Set the status of the card
            card.isFlipped = true
            
            // Determine if it's the first card or second that's flipped over
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                
                // This is the second card being flipped
                
                // perform the matching logic
                checkForMatches(indexPath)
                
            }
        }
        else {
            cell.flipBack()
            card.isFlipped = false
        }
        
        
    } // End the didSelectItemAt method
    
    // MARK: - Game Logic Methods
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        
        // Get the cells for the two cars that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // get the cards for the two cards that were revealed
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            //It's a match
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            //Remove the cards from the grid
            cardOneCell!.remove()
            cardTwoCell!.remove()
            //Check if there are any cards left unmatched
            checkGameEnded()
        }
        else {
            
            //It's not a match
            
            
            //Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            checkGameEnded()
        }
        
        
        firstFlippedCardIndex = nil
        
        func checkGameEnded() {
            // Determine if there are any cards unmatched
            var isWon = true
            
            for card in cardArray {
                
                if card.isMatched == false {
                    isWon = false
                    break
                }
            }
            //Messaging variables
            var title = ""
            var message = ""
            
            //If not, then user has won, stop the timer
            if isWon == true {
                if milliseconds > 0 {
                    timer?.invalidate()
                }
                title = "Congratulations!"
                message = "You've defused the nuke"
                
            }
            else {
                if milliseconds > 0 {
                    return
                }
                
                title = "Game Over"
                message = "Your friends are died"
            }
            
            
            //Show won/lost messaging
            showAlert(title,message)
        }
        
        func showAlert(_ title:String, _ message:String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
        
    } // End ViewController Class
    
    

