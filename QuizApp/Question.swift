//
//  Question.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/28/21.
//

import Foundation

struct Question: Codable {
    
    // What is the question
    var question:String?
    
    // Multiple choice answers
    var answers:[String]?
    
    // The correct answer index
    var correctAnswerIndex:Int?
    
    // Why they got the question wrong or congratulating on getting it right
    var feedback:String?
    
    
}
