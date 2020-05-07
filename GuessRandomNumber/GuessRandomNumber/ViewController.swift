//
//  ViewController.swift
//  GuessRandomNumber
//
//  Created by Julia Debecka on 07/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func guessTapped(_ sender: Any) {
        let random = Int.random(in: 0...10)
        
        if let text = textField.text {
            switch Int(text) {
            case random:
                resultLabel.text = "You're right"
            default:
                resultLabel.text = "Nah, I was holding \(random) imaginary fingers up!"
            }
        }
    }
}

