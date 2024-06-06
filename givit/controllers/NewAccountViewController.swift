//
//  ViewController.swift
//  givit
//
//  Created by Alex Balla on 01.06.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, err) in
            if err != nil {
                self.showError(text: "Error creating user!", errorLabel: self.errorLabel, textFields: [self.emailField, self.passwordField, self.passwordConfirmField])
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["email": "\(self.emailField.text!)",
                                                          "uid": result!.user.uid,
                                                          "account_creation_date": "\(Date().formatted())",
                                                          "account_type": "user"]) { (error) in
                    if error != nil {
                        self.showError(text: "Failed to save data on Firebase server", errorLabel: self.errorLabel, textFields: [self.emailField, self.passwordField, self.passwordConfirmField])
                        return
                    } else {
                        self.succeedError(label: self.errorLabel)
                    }
                }
            }
        }
    }
}

extension UIViewController {
    func showError(text: String, errorLabel: UILabel, textFields: [UITextField]) {
        errorLabel.isHidden = false
        errorLabel.text = text
        for field in textFields {
            field.layer.borderColor = UIColor.systemRed.cgColor
            field.layer.borderWidth = 1
        }
    }
    
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
    
    func succeedError(label: UILabel) {
        label.textColor = .systemGreen
        label.text = "Succeed"
        label.isHidden = false
    }
}

