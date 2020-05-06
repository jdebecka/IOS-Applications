//
//  CurrencyAPI.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 05/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation
struct CurrencyRepository {
    static func getAllCurrencies(_ completion: @escaping ((Currency?) -> Void)) {
        
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: "Common-Currency", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let currencyInfo = try decoder.decode(Currency.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(currencyInfo)
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            

        }
    }
}
