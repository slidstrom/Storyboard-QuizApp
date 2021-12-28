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
        
        // Fetch the questions
        getLocalJsonFile()
        
    }
    
    func getLocalJsonFile() {
        
        // Get path to json
        let dataPath = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard dataPath != nil else {
            print("Couldn't find the json data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: dataPath!)
        
        do{
            // Get the data from the uurl
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            do {
                let array = try decoder.decode([Question].self, from: data)
                
                delegate?.questionsRetrieved(array)
                
            }
            catch{
                print(error)
            }
            
            
        }
        catch{
            // Error: Couldn't download the data at that URL
            print("Couldn't download the data")
        }
        
    }
    
    func getRemoteJsonFile(){
        
    }
    
}
