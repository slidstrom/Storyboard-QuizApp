//
//  ViewController.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/28/21.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource {
    // IBOutlets
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
        
    // Create quiz model object
    var model = QuizModel()
    
    // The array of questions
    var questions = [Question]()
    
    // What question is the user looking at
    var currentQuestionIndex = 0
    
    // how many correct answers so far
    var numCorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set up the model
        model.delegate = self
        model.getQuestions()
        
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        
        // Get a reference to the questions
        self.questions = questions
        
        // Reload the tableview
        tableView.reloadData()
    }
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        
        // Make sure that the questions array actually contains at least a question
        guard questions.count > 0 else {
            return 0
        }
        
        // Return number of answers for this question
        let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.answers != nil {
            return currentQuestion.answers!.count
        }
        else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        // Customize the cell
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            // TODO: Set the answer text for the label
            
        }
        
        // Return the cell
        return cell
        
    }
    


}

