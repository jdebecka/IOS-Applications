//
//  CookEggsViewController.swift
//  Egg Timer
//
//  Created by Julia Debecka on 09/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class CookEggsViewController: UIViewController {

    @IBOutlet weak var saveUserDefaults: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var boilingButton: UIButton!
    @IBOutlet weak var potButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var eggKind: String = ""
    var eggSize: String = ""
    var cookTime: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookTime = timeForEggs()
        timeLabel.text = "Recommended Time: " + String(cookTime / 60)
        saveUserDefaults.roundCorners()
        minusButton.roundCorners()
        plusButton.roundCorners()
        boilingButton.roundCorners()
        potButton.roundCorners()
        startButton.roundCorners()
        setup()
    }
    
    @IBAction func minusTapped(_ sender: Any) {
    }
    @IBAction func plusTapped(_ sender: Any) {
    }
    @IBAction func waterIsBoilingTapped(_ sender: Any) {
        boilingButton.isEnabled = false
        boilingButton.backgroundColor = .systemGray6
        potButton.isEnabled = true
        potButton.backgroundColor = .systemYellow
    }
    @IBAction func EggsInPodTapped(_ sender: Any) {
        potButton.isEnabled = false
        potButton.backgroundColor = .systemGray6
        startButton.isEnabled = true
        startButton.backgroundColor = .systemYellow
        
    }
    @IBAction func startTimerTapped(_ sender: Any) {
        startButton.isEnabled = true
        startButton.backgroundColor = .systemGray6
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

fileprivate extension CookEggsViewController {
    
    func setup() {
        let colors = [UIColor.white.cgColor, CGColor(srgbRed: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),  CGColor(srgbRed: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), CGColor(srgbRed: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        
        let gradientLayer = self.view.getGradientLayer(with: colors, for: [1.0, 1.0, 0.0, 0.0])
        
        let animation = makeAnimation()
        
        gradientLayer.add(animation, forKey: nil)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    enum BaseTime {
        case soft, medium, hard
        
        var time: Double {
            switch self {
            case .soft:
                return 3 * 60
            case .medium:
                return 4.30 * 60
            case .hard:
                return 12 * 60
            }
        }
    }
    
    enum TimeForSize {
        case small, medium, large
        
        var time: Double {
            switch self {
            case .small:
                return 0
            case .medium:
                return 1.30 * 60
            case .large:
                return 2 * 60
            }
        }
    }

    func timeForEggs() -> Double {
        var time = { () -> Double in
            switch eggKind {
            case "Soft":
                return BaseTime.soft.time
            case "Hard":
                return BaseTime.hard.time
            default:
                return BaseTime.medium.time
            }
        }()
        
        if eggSize != "Small" {
            if eggSize == "Medium" {
                time += TimeForSize.medium.time
            }
            else {
                time += TimeForSize.large.time
            }
        }
        return time
    }
    
    func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [ 1.0, 1.0, 1.0, 1.0]
        animation.toValue = [0.0, 0.4, 0.6, 1.0]
        animation.duration = 20
        return animation
    }
}
