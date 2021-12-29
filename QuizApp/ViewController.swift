//
//  ViewController.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/28/21.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {
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
    
    // Properties for the modal
    var resultDialog:ResultViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize the result dialog
        resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
        
        // Set self as the delegate and datasource for the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Dynamic row heights (This xcode version is missing the automatic check box)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        // Set up the model
        model.delegate = self
        model.getQuestions()
        
    }
    
    func displayQuestion() {
        
        // Check if there are questions, and check that the currentQuestionIndex is not out of bounds
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            return
        }
        
        // Display the question text
        questionLabel.text = questions[currentQuestionIndex].question

        // Reload the answers table
        tableView.reloadData()
        
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        
        // Get a reference to the questions
        self.questions = questions
        
        // Check if we should restore the state before showing question number one
        let savedIndex = StateManager.retrieveValue(key: StateManager.questionIndexKey) as? Int
        let savedNumCorrect = StateManager.retrieveValue(key: StateManager.numCorrectKey) as? Int
        
        if savedIndex != nil && savedIndex! < self.questions.count {
            
            // Set the current question to the saved index
            currentQuestionIndex = savedIndex!
            // Set current number correct
            numCorrect = savedNumCorrect!
        }
        
        // Display the first question
        displayQuestion()
        
    }
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        
        // Make sure that the questions array actually contains at least a question
        guard questions.count > 0 else {
            return 0
        }
        
        // Return number of answers for this question (guard above because questions array is nil to start)
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

            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count{
                // Set the label
                label!.text = question.answers![indexPath.row]
            }
        }
        
        // Return the cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titleText = ""
        
        // User has tapped on a row, check if it's the right answer
        let question = questions[currentQuestionIndex]
        
        guard question.correctAnswerIndex != nil else{
            
            return
        }
        if question.correctAnswerIndex! == indexPath.row{
            // User got it right
            print("User got it right")
            titleText = "Correct!"
            numCorrect += 1

        }
        
        else{
            // User got it wrong
            print("User got it wrong")
            titleText = "Wrong"
        }
        
        // Show the popup
        if resultDialog != nil {
            
            // Customize the dialog text
            resultDialog!.titleText = titleText
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
            
            present(resultDialog!, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - ResultViewControllerProtocol Methods
    
    func dialogDismissed() {
        
        // Increment the currentQuestinIndex
        currentQuestionIndex += 1
        
        // Increment the currentQuestion Index
        if currentQuestionIndex == questions.count {
            
            // The user has just answered the last question
            // Show a summary dialog
            if resultDialog != nil {
                
                // Customize the dialog text
                resultDialog!.titleText = "Summary"
                resultDialog!.feedbackText = "You got \(numCorrect) correct out of \(questions.count) questions"
                resultDialog!.buttonText = "Restart"
                
                present(resultDialog!, animated: true, completion: nil)
                
                // Clear State
                StateManager.clearState()
            }
            
        }
        else if currentQuestionIndex > questions.count {
            // Restart
            currentQuestionIndex = 0
            numCorrect = 0
            displayQuestion()
            
        }
        else if currentQuestionIndex < questions.count {
                        
            // Display the next question
            displayQuestion()
            
            // Save State
            StateManager.saveState(numCorrect: numCorrect, questionIndex: currentQuestionIndex)
            
        }
        
    }
    
    
}

