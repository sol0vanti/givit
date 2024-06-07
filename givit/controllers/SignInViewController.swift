//
//  SignInViewController.swift
//  givit
//
//  Created by Alex Balla on 01.06.2024.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemRed
    }
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        let checkFill = checkFieldsOnFill(textFields: [emailField, passwordField], errorLabel: errorLabel)
        guard checkFill == nil else {
            return
        }
        
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.showError(text: "Cannot sign in your account!", errorLabel: self.errorLabel, textFields: [self.emailField, self.passwordField])
            }
            else {
                self.succeedError(label: self.errorLabel)
            }
        }
    }
}
