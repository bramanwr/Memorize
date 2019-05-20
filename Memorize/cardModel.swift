//
//  cardModel.swift
//  Memorize
//
//
// Created by Bram Anwar on 18/05/19.
//  Copyright © 2019 Bram Anwar. All rights reserved.
//

import Foundation
class CardModel  {
    func getCards() -> [Card] {
        // Deklarasi array untuk menyimpan kartu yang digenerasi
        var generatedCardsArray = [Card]()
       // Generate sepasang kartu secara random
        for _ in 1...6 {
        // Membuat nomor random
          let randomNumber = arc4random_uniform(6) + 1
        
        print("generating a random \(randomNumber)")
            
        let cardOne = Card()
        cardOne.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardOne)
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        
        generatedCardsArray.append(cardTwo)
        }
        
        print(generatedCardsArray.count)
        // Return Array
        return generatedCardsArray
    }
}
