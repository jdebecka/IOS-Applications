//
//  CookEggsViewController.swift
//  Egg Timer
//
//  Created by Julia Debecka on 09/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import AVFoundation

class CookEggsViewController: UIViewController {

    @IBOutlet weak var saveUserDefaults: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var boilingButton: UIButton!
    @IBOutlet weak var potButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    var gradientLayer: CAGradientLayer!
    var key: String!
    
    var eggKind: String = ""
    var eggSize: String = ""
    var cookTime: Double!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        key = eggSize + eggKind
        cookTime = timeForEggs()
        getUserPreference()
        updateTimeLabel()
        saveUserDefaults.roundCorners()
        minusButton.roundCorners()
        plusButton.roundCorners()
        boilingButton.roundCorners()
        potButton.roundCorners()
        startButton.roundCorners()
        setup()
    }
    
    @IBAction func saveAsPreffered(_ sender: Any) {
        guard let time = timeLabel.text else { return }
        let messageEgg = "\(time) as your prefered time for egg of size: \(eggSize) and cooked: \(eggKind)"
        let alert = UIAlertController(title: "Do you want to save?", message: messageEgg, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.saveUserPreserence()
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func minusTapped(_ sender: Any) {
        cookTime -= 1
        updateTimeLabel()
    }
    @IBAction func plusTapped(_ sender: Any) {
        cookTime += 1
        updateTimeLabel()
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
        timerForEggs()
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
    func eggsReadyAlarm() {
        guard let url = Bundle.main.url(forResource: "Radar", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
            
        }catch {
            print(error)
        }
    }
    func saveUserPreserence() {
        UserDefaults.standard.set(cookTime, forKey: key)
    }

    func getUserPreference() {
        if let userPreferences = UserDefaults.standard.object(forKey: key) as? Double {
            cookTime = userPreferences
            updateTimeLabel()
        }
    }
    
    func updateTimeLabel() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        let formattedString = formatter.string(from: TimeInterval(cookTime))!
        
        timeLabel.text = "Recommended Time: \(formattedString)"
    }
    func setup() {
        let colors = [UIColor.white.cgColor, CGColor(srgbRed: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),  CGColor(srgbRed: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), CGColor(srgbRed: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)]
        
        gradientLayer = self.view.getGradientLayer(with: colors, for: [1.0, 1.0, 0.0, 0.0])
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    enum BaseTime {
        case soft, medium, hard
        
        var time: Double {
            switch self {
            case .soft:
                return 3 * 60
            case .medium:
                return 4.50 * 60
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
                return 1.5 * 60
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
    
    @objc func secondPassed() {
        if cookTime > 0 {
            cookTime = cookTime - 1
            updateTimeLabel()
        }else {
            timer.invalidate()
        }
        
        
    }
    
    func makeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [ 1.0, 1.0, 1.0, 1.0]
        animation.toValue = [0.0, 0.4, 0.6, 1.0]
        animation.duration = cookTime
        return animation
    }
    func timerForEggs() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CookEggsViewController.secondPassed), userInfo: nil, repeats: true)
        let animation = makeAnimation()
        gradientLayer.add(animation, forKey: nil)
    }
}
