//
//  BitcoinAPI.swift
//  Bitcoint Price Tracker
//
//  Created by Julia Debecka on 05/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation
import Alamofire

enum BitcoinAPI {
    case bitcoinPrice([String])
    
    private var basePath: String {
        return "https://min-api.cryptocompare.com"
    }
    
    var endpoints: String {
        return "/data/price"
    }
    
    var url: URL? {
        return URL(string: path)
    }
    
    var path: String {
        return basePath + endpoints
    }
    
    var quaryParams: Parameters {
        var params = ["fsym" : "BTC"]
        
        switch self {
        case .bitcoinPrice(let currencies):
            let stringParams = currencies.joined(separator: ",")
            params["tsyms"] = stringParams
        }
        return params
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}
struct BitcoinRepository {
    typealias BitcoinCurrency = [String: Double]
    
    static func getCurrentBitcoin(for currencyCodes: [String], completion: @escaping ((BitcoinCurrency?, Error?) -> Void)) {
        executeRequest(.bitcoinPrice(currencyCodes), completion: completion)
    }
    
    private static func executeRequest<T: Codable>(_ request: BitcoinAPI, completion: @escaping ((T?, Error?) -> Void)) {
        guard let requestURL = request.url else { return }
        
        
        AF.request(requestURL, parameters: request.quaryParams).response { response in
            guard let data = response.data else { return }
            print(data)
            do{
                let decoder = JSONDecoder()
                let responseObject: T = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
