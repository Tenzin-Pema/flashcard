//
//  ViewController.swift
//  flashcard
//
//  Created by Tenzin Pema on 10/13/18.
//  Copyright © 2018 Tenzin Pema. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
    frontLabel.isHidden = true
    }
    
}
