//
//  DetailViewController.swift
//  BeerMi
//
//  Created by Julia Debecka on 08/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    var text: String = {
        let beerName = ""
        return beerName
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = text
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
