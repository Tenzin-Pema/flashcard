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
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var edit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        edit.layer.cornerRadius = 15.0
        
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btnOptionOne.layer.borderWidth = 2.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnOptionTwo.layer.borderWidth = 2.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnOptionThree.layer.borderWidth = 2.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        
        if segue.identifier == "editSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true{
            frontLabel.isHidden = false
        } else {
            frontLabel.isHidden = true
        }
    }
    func updateFlashcard(question: String, answer: String, choiceOne: String, actualAns: String, choiceThree: String) {
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(choiceOne, for: .normal)
        btnOptionTwo.setTitle(actualAns, for: .normal)
        btnOptionThree.setTitle(choiceThree, for: .normal)
    }
    @IBAction func didTapOptionOne(_ sender: UIButton) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: UIButton) {
        btnOptionOne.isHidden = true
        btnOptionThree.isHidden = true
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: UIButton) {
        btnOptionThree.isHidden = true
    }
    
    
}

