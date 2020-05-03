import UIKit

import PlaygroundSupport

var str = "Hello, playground"

//multiple interherence
protocol Flashable{
    func flash()
}

extension Flashable where Self: UIView {
    func flash() {
        alpha = 1
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.25,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.alpha = 0
        })
    }
}

protocol Raisable {
    func raise()
}

extension Raisable where Self: UIView {
    func raise() {
        transform = .identity
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.25,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 3)
        })
        
    }
}

class NewView: UIView, Raisable, Flashable {}
class ViewController: UIViewController {
    override func loadView() {
        super.loadView()
        let view = NewView()
        view.backgroundColor = .orange
        view.raise()
        view.flash()
        
        self.view = view
        
    }
}
//PlaygroundPage.current.liveView = ViewController()
