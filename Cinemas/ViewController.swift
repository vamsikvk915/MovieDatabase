//
//  ViewController.swift
//  Cinemas
//
//  Created by vamsi krishna reddy kamjula on 7/31/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newUserButton(_ sender: Any) {
        performSegue(withIdentifier: "newUser", sender: self)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
            user, error in
            if error != nil {
                let alertAction = UIAlertController(title: "Incorrect", message: "The useremail/password doesn't match !!!", preferredStyle: .alert)
                alertAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alertAction, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "login", sender: self)
            }
        })
    }
}

