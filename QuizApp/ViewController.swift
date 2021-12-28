//
//  ViewController.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/28/21.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
        
    // Create quiz model object
    var model = QuizModel()
    
    // The array of questions
    var questions = [Question]()
    
    // What question is the user looking at
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.delegate = self
        model.getQuestions()
        
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        print("Questions retrieved from model")
    }
    


}

