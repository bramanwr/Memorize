//
//  ViewController.swift
//  Memorize
//
//  Created by Bram Anwar on 18/05/19.
//  Copyright © 2019 Bram Anwar. All rights reserved.
//

import UIKit
// Dekralarasi dulu
class ViewController: UIViewController {
    
    var model = CardModel()
    var cardArray = [Card]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

