//
//  Currency.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 05/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

struct CurrencyValue: Codable, Hashable {
    
    let symbol, name, symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code, namePlural: String

    enum CodingKeys: String, CodingKey {
        case symbol, name
        case symbolNative = "symbol_native"
        case decimalDigits = "decimal_digits"
        case rounding, code
        case namePlural = "name_plural"
    }
}

typealias Currency = [String: CurrencyValue]

extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        return self[index(startIndex, offsetBy: i)]
    }
}
