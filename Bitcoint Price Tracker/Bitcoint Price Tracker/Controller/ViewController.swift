//
//  ViewController.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 04/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    typealias BitcoinCurrency = [String: Double]
    @IBOutlet weak var usdLabel: UILabel!
    
    var bitcoinCurrency: BitcoinCurrency = [:]
    var userCurrencyCodes = Set<String>()
    var allCurrencies: Currency = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        userCurrencyCodes.update(with: "USD")
        CurrencyRepository.getAllCurrencies( { (currency) in
            if let allCurrencies = currency {
                self.allCurrencies = allCurrencies
            }
        })
        getUsersCurrency()
        getBitcoinPrices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func refreshTapped(_ sender: Any) {
        getUsersCurrency()
        getBitcoinPrices()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCurrencyCodes.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var index = self.userCurrencyCodes.startIndex
            index = self.userCurrencyCodes.index(index, offsetBy: indexPath.row)
            self.userCurrencyCodes.remove(at: index)
            deleFromUserDefaults()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CustomTableCell else { return UITableViewCell() }
        
        let code = Array(self.userCurrencyCodes)[indexPath.row]
    
        if let currentPrice = bitcoinCurrency[code] {
            let price = currencyFormatter(price: currentPrice, currencyCode: code)
            cell.currencyLabel.text = price
        }else {
            cell.currencyLabel.text = code
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

fileprivate extension ViewController {
    
    func getUsersCurrency() {
        let decoder = JSONDecoder()
        do {
            if let prepreviousData = UserDefaults.standard.data(forKey: "currency") {
                let previousCurrency = try decoder.decode(Set<String>.self, from: prepreviousData)
                self.userCurrencyCodes.formUnion(previousCurrency)
            }
        }catch {
            print(error)
        }
    }
    
    func deleFromUserDefaults() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userCurrencyCodes)
            UserDefaults.standard.set(data, forKey: "currency")
        }catch {
            print(error)
        }
        getBitcoinPrices()
    }
    
    func currencyFormatter(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        
        if priceString == nil {
            return "ERROR"
        }else {
            return priceString!
        }
    }
    
    func getBitcoinPrices() {
        BitcoinRepository.getCurrentBitcoin(for: Array(userCurrencyCodes)) { (bitcoinCurrent, error) in
            guard let bitcoinCurrent = bitcoinCurrent else { return }
            
            DispatchQueue.main.async {

                self.bitcoinCurrency = bitcoinCurrent
                if let doubleUSD = self.bitcoinCurrency["USD"] {
                    if let symbol = self.allCurrencies["USD"]?.symbol {
                        self.usdLabel.text = self.currencyFormatter(price: doubleUSD, currencyCode: symbol)
                    }else {
                        self.usdLabel.text = "\(doubleUSD)"
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
}
