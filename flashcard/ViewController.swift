//
//  ViewController.swift
//  flashcard
//
//  Created by Tenzin Pema on 10/13/18.
//  Copyright © 2018 Tenzin Pema. All rights reserved.
//

import UIKit
// create flashcard object
struct Flashcard{
    var question: String
    var answer: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var edit: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    
    // array to store flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI formatting
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
        
        readSavedFlashCards()
        if flashcards.count == 0{
        updateFlashcard(question: "Which country won the 2016 Rugby World Cup?", answer: "New Zealand", isExisting: true, choiceOne: "England", actualAns: "New Zealand", choiceThree: "South Africa")
        }else{
            updateLabel()
            updateNextPrevButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        // if edit is triggered, current question&answer is available to edit in
        // CreationViewController
        if segue.identifier == "editSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
        
    }
    
    @IBAction func didTapOnNext(_ sender: UIButton) {
        // increase currentIndex
        currentIndex += 1
        // update label
        updateLabel()
        // update next/prev button
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrevious(_ sender: UIButton) {
        currentIndex -= 1
        updateLabel()
        updateNextPrevButtons()
        
    }
    
// function to flip card
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if frontLabel.isHidden == true{
            frontLabel.isHidden = false
        } else {
            frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Delete Flashcard?", message: "Are you sure you want to delete current card?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func deleteCurrentFlashcard(){
        //delete flashcard at current index
        let alert = UIAlertController(title: "Delete flashcard", message: "There aren't any flashcards left", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        if flashcards.count > 1{
            flashcards.remove(at: currentIndex)
        }else{
            present(alert, animated: true)
            
        }
        
        //refresh index value
        if currentIndex > flashcards.count - 1{
            currentIndex = flashcards.count - 1
        }
        updateLabel()
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()
        
    }
    
    
    
    
    
    // function to add new card
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool, choiceOne: String, actualAns: String, choiceThree: String) {
        
        // initialize card object
        let flashcard = Flashcard(question: question, answer: answer)
        
        if isExisting{
            // Replace existing flashcard
            flashcards[currentIndex] = flashcard
            
        }else{
            // Adding flashcard in array
            flashcards.append(flashcard)
        }
       
        
        // update current index
        currentIndex = flashcards.count - 1
        
        // update buttons
        updateNextPrevButtons()
        
        // update label
        updateLabel()
        
        btnOptionOne.setTitle(choiceOne, for: .normal)
        btnOptionTwo.setTitle(actualAns, for: .normal)
        btnOptionThree.setTitle(choiceThree, for: .normal)
        
        // save flashcard to disk
        saveAllFlashcardsToDisk()
    }
    func updateNextPrevButtons() {
        // disable next button if last flashcard is shown
        if currentIndex == flashcards.count - 1 {
            nextBtn.isEnabled = false
            nextBtn.isHidden = true
        } else{
            nextBtn.isEnabled = true
            nextBtn.isHidden = false
        }
        // disable previous button if first flashcard is shown
        if currentIndex == 0{
            prevBtn.isEnabled = false
            prevBtn.isHidden = true
        }else{
            prevBtn.isEnabled = true
            prevBtn.isHidden = false
        }
    }
    
    func updateLabel(){
        // What is current flashcard?
        let currentFlashcard = flashcards[currentIndex]
        // update label
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        // from flashcardArray to Dictionary array
        let dictArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer ]
        }
        // save array
        UserDefaults.standard.set(dictArray, forKey: "flashcards")
        
        // debug
        print("Flashcards saved to UserDefaults")
        print(flashcards)
        
    }
    func readSavedFlashCards(){
        // read from UserDefault
        if let dictArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictArray.map { (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
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

