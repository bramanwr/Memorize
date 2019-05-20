//
//  CardCollectionViewCell.swift
//  Memorize
//
//  Created by Bram Anwar on 20/05/19.
//  Copyright © 2019 Bram Anwar. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!

    var card:Card?
    
    func setCard(_ card:Card){
        
        self.card = card
        
        if card.isMatched == true {
           // If the card has been matched, then make the image views invisibile
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            
        }
        
    }
    
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            

        }
        
        
        
        
    }
    
    func remove() {
        //Removes both imageviews from being visible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
    }
}
