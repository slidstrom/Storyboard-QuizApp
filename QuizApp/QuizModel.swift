//
//  QuizModel.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/28/21.
//

import Foundation

// Custom protocol - when the background thread comes back from fetching the json data, it has a reference to the view controller so that it can notify that view controller and pass the data to it for display
protocol QuizProtocol {
    
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // TODO: Fetch the questions
        
        // Notify the delegate of the retrieved questions
        delegate?.questionsRetrieved([Question]())
        
    }
    
}
