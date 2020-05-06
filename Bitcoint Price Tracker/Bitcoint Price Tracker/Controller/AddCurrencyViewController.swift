//
//  AddCurrencyViewController.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 05/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class AddCurrencyViewController: UIViewController {
    
    @IBOutlet weak var chosenValueLabel: UILabel!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    var allCurrencies: Currency = [:]
    var keys: [String] = []
    var attributedLabels: [NSAttributedString] = []
    var addedCurrencies = Set<String>()
    
    override func loadView() {
        super.loadView()
        CurrencyRepository.getAllCurrencies( { (currency) in
            if let allCurrencies = currency {
                self.allCurrencies = allCurrencies
                for currency in self.allCurrencies {
                    self.attributedLabels.append(self.formatString(currency.value.name, currency.value.code))
                }
                self.keys = Array(self.allCurrencies.keys)
                self.chosenValueLabel.text = self.keys[0]
            }
            self.CurrencyPicker.reloadAllComponents()
        })
        getUsersCurrency()
    }
    @IBAction func addTapped(_ sender: Any) {
        if let key = self.chosenValueLabel.text {
            self.addedCurrencies.insert(key)
            addToUserDefaults()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
    }
}

extension AddCurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel?
        
        if view == nil {
            pickerLabel = UILabel()
        }
        
        pickerLabel!.attributedText = attributedLabels[row]
        pickerLabel!.textAlignment = .center
        pickerLabel!.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let key = keys[row]
        self.chosenValueLabel.text = self.allCurrencies[key]?.code
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let key = keys[row]
        guard let name = self.allCurrencies[key]?.name else { return nil }
        guard let code = self.allCurrencies[key]?.code else { return nil }
        return  "\(name) \(code)"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCurrencies.count
    }
}

fileprivate extension AddCurrencyViewController {
    func formatString(_ name: String, _ code: String) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString()
        let lightAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.light),
                               NSAttributedString.Key.foregroundColor: UIColor.white]
        let mediumAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.medium),
                                NSAttributedString.Key.foregroundColor: UIColor.white]
        attributedString.append(NSMutableAttributedString(string: name, attributes: mediumAttributes))
        attributedString.append(NSMutableAttributedString(string: " \(code)", attributes: lightAttributes))
        return attributedString
    }
    
    func getUsersCurrency() {
        let decoder = JSONDecoder()
        do {
            if let prepreviousData = UserDefaults.standard.data(forKey: "currency") {
                let previousCurrency = try decoder.decode(Set<String>.self, from: prepreviousData)
                self.addedCurrencies.formUnion(previousCurrency)
            }
        }catch {
            print(error)
        }
    }
    
    func addToUserDefaults() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(addedCurrencies)
            UserDefaults.standard.set(data, forKey: "currency")
        }catch {
            print(error)
        }
    }
}
