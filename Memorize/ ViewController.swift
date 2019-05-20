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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        }
        else {
            
            //It's not a match
            
            //Set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
    
    
        firstFlippedCardIndex = nil
    
    
    } // End ViewController Class


}
