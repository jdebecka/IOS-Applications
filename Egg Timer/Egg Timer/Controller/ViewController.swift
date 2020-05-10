//
//  ViewController.swift
//  Egg Timer
//
//  Created by Julia Debecka on 07/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    
    var eggSize: String!
    var preference: String!
    
    @IBOutlet weak var cookEggsButon: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    @IBOutlet weak var mediumButton: UIButton!
    
    @IBOutlet weak var smallButton: UIButton!
    
    @IBOutlet weak var soft: UIButton!
    
    @IBOutlet weak var medium: UIButton!
    
    @IBOutlet weak var hard: UIButton!
    
    var sizeButtons: [UIButton] = []
    var prefrenceButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradient()
        sizeButtons.append(contentsOf: [largeButton, mediumButton, smallButton])
        prefrenceButtons.append(contentsOf: [soft, medium, hard])
        roundCorders()
    }
    
    @IBAction func largeTapped(_ sender: Any) {
       animateTap(largeButton)
    }
    @IBAction func mediumTapped(_ sender: Any) {
        animateTap(mediumButton)
    }
    @IBAction func smallTapped(_ sender: Any) {
        animateTap(smallButton)
    }
    @IBAction func softTapped(_ sender: Any) {
        animateTap(soft)
    }
    @IBAction func mediumCookTapped(_ sender: Any) {
        animateTap(medium)
    }
    @IBAction func hardTapped(_ sender: Any) {
        animateTap(hard)
    }
    @IBAction func startCookingTapped(_ sender: Any) {
        if (eggSize == nil) || (preference == nil) {
            let didNotSelectedAlert = UIAlertController(title: "Select Your Egg Size and Preference", message: "I will calculate time based on these two parameters", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            didNotSelectedAlert.addAction(alertAction)
            self.present(didNotSelectedAlert, animated: true, completion: nil)
        }else {
            let cookEggVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CookEggViewContoller") as! CookEggsViewController
            cookEggVC.eggKind = preference
            cookEggVC.eggSize = eggSize
            
            navigationController?.pushViewController(cookEggVC, animated: true)
        }
    }
}


fileprivate extension ViewController {
    func setUpGradient() {
        let colors = [UIColor.white.cgColor, CGColor(srgbRed: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),  CGColor(srgbRed: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), CGColor(srgbRed: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        
        let gradientLayer = self.view.getGradientLayer(with: colors, for: [0.2, 0.6, 0.8, 1.0])
        let animation = makeAnimation()
        gradientLayer.add(animation, forKey: nil)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func roundCorders() {
        sizeButtons.forEach { $0.roundCorners() }
        prefrenceButtons.forEach { $0.roundCorners() }
        cookEggsButon.roundCorners()
    }
    func animateTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: .transitionCrossDissolve, animations: {
            sender.backgroundColor = .white
        }) { (completed) in
            self.createListOfDiselected(sender)
        }
    }
    
    func createListOfDiselected(_ sender: UIButton) {
        var list: [UIButton] = []
        if self.sizeButtons.contains(sender) {
            eggSize = sender.titleLabel?.text
            list = self.sizeButtons.filter { $0 != sender }
        }
        else if self.prefrenceButtons.contains(sender) {
            preference = sender.titleLabel?.text
            list = self.prefrenceButtons.filter { $0 != sender }
        }
        self.diselectButton(list)
    }
    
    func diselectButton(_ buttons: [UIButton]) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: .transitionCrossDissolve, animations: {
            buttons.forEach { $0.backgroundColor = .systemYellow }
        }, completion: nil)
    }
    
    func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.2, 0.6, 0.8, 1.0]
        animation.toValue = [0.0, 0.2, 0.4, 1.0]
        animation.duration = 2.5
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }
}

