//
//  ViewController.swift
//  SnapFun
//
//  Created by Julia Debecka on 25/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var logInMode = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func TopTapped(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text{
                
                if !logInMode {
                    Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
                        if error == nil {
                            print("User created")
                        }else {
                            print(error)
                        }
                        
                    }
                }else {
                    Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                        if error == nil {
                            print("User logged in")
                        }
                    }
                }
            }
            
        }
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        if logInMode {
            logInMode = false
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
        }else {
            logInMode = true
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
        }
    }
    
}

