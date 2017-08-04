//
//  SignUpViewController.swift
//  Cinemas
//
//  Created by vamsi krishna reddy kamjula on 7/31/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var useremailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: useremailTextField.text!, password: passwordTextField.text!, completion: {
            user, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Try Again", message: "Enter your details.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "newUserLoggedIn", sender: self)
            }
        })
    }
}
