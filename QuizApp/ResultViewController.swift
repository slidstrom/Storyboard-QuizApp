//
//  ResultViewController.swift
//  QuizApp
//
//  Created by DSIAdmin on 12/29/21.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
    
}

class ResultViewController: UIViewController {
    
    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate:ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Round the dialog box corners
        dialogView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Now that the elements have loaded, set the text
        titleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        // TODO: Dismiss the popup
        dismiss(animated: true, completion: nil)
        
        // Notify delegate the popup was dismissed
        delegate?.dialogDismissed()
        
    }
    

}
