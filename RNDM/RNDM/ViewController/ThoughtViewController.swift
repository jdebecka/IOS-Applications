//
//  ThoughtViewController.swift
//  RNDM
//
//  Created by Julia Debecka on 15/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import Firebase

class ThoughtViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        usernameText.delegate = self
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postTapped(_ sender: Any) {
        guard (usernameText.text != "") else {
            usernameText.borderStyle = .roundedRect
            usernameText.textColor = .red
            usernameText.text = "Required!"
            return }
        if let thoughtData = gatherThoughtInformation() {
            
            Firestore.firestore().collection("thoughts").addDocument(data: thoughtData.returnData()) { (error) in
                if let error = error {
                    debugPrint("Error adding document: \(error)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }

    }
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    func gatherThoughtInformation() -> Thought? {
        guard let username = usernameText.text else { return nil }
        let thought = Thought(category: selectedCategory, numComments: 0, thoughtTxt: textView.text, numLikes: 0, timestamp: FieldValue.serverTimestamp(), username: username)
        return thought
    }
    func setup() {
        postButton.layer.cornerRadius = 4
        textView.layer.cornerRadius = 4
        textView.text = "My random thought..."
        textView.textColor = .lightGray
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThoughtViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .darkGray
    }
}

extension ThoughtViewController :UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        usernameText.borderStyle = .none
        usernameText.text = ""
        usernameText.textColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
    }
}
