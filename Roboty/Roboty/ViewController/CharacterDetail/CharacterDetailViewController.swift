//
//  CharacterDetailViewController.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoButton: customButton!
    @IBOutlet weak var scriptButton: customButton!
    var scriptLabal: String = {
        let text = ""
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = scriptLabal
        scriptButton.titleLabel?.text = scriptLabal
    }
    
    
    var data: Character {
        didSet {
            self.scriptButton.titleLabel?.text = data.polishCharacterName
        }
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
