//
//  CreationViewController.swift
//  flashcard
//
//  Created by Tenzin Pema on 1/8/19.
//  Copyright © 2019 Tenzin Pema. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var choiceOne: UITextField!
    @IBOutlet weak var actualAns: UITextField!
    @IBOutlet weak var choiceThree: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: UIBarButtonItem) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let firstChoice = choiceOne.text
        let secondChoice = actualAns.text
        let thirdChoice = choiceThree.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty{
            
            let alert = UIAlertController(title: "Missing Text", message: "You need both a question and answer", preferredStyle: UIAlertController.Style .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        else{
            var isExisting = false
            if initialQuestion != nil{
                isExisting = true
            }
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting ,choiceOne: firstChoice!, actualAns: secondChoice!, choiceThree: thirdChoice!)
            dismiss(animated: true)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
