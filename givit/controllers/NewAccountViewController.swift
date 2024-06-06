//
//  ViewController.swift
//  givit
//
//  Created by Alex Balla on 01.06.2024.
//

import UIKit

class NewAccountViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonClicked(_ sender: UIButton) {
        print("Clicked")
        let error = checkFieldsOnFill(textFields: [emailField, passwordField, passwordConfirmField], errorLabel: errorLabel)
        guard error == nil else {
            return
        }
        errorLabel.textColor = .systemGreen
        errorLabel.text = "Succeed"
        errorLabel.isHidden = false
    }
}

extension UIViewController {
    func checkFieldsOnFill(textFields: [UITextField]?, errorLabel: UILabel) -> String? {
    var errorText: String? = nil
        
        guard !textFields!.isEmpty else {
            errorText = "No text fields set!"
            errorLabel.isHidden = false
            errorLabel.text = errorText!
            return errorText!
        }
        
        for field in textFields! {
            if field.text == "" {
                errorText = "You didn't fill all text fields properly!"
                errorLabel.isHidden = false
                errorLabel.text = errorText
                field.layer.borderColor = UIColor.systemRed.cgColor
                field.layer.borderWidth = 1
                return errorText
            }
        }
        
        return nil
    }
}

