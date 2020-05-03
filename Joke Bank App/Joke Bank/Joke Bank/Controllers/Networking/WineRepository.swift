//
//  WineData.swift
//  Joke Bank
//
//  Created by Julia Debecka on 04/04/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation
import Alamofire

struct WineRepository {
    
    static let address = "https://raw.githubusercontent.com/hollyschinsky/angular-cellar-basic/master/wines/wines.json"
    
    static func getAllWines(_ completion: @escaping ((Wine?, Error?) -> Void)){
        
        if let url = URL(string: WineRepository.address) {
            AF.request(url, method: .get).response { response in
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let wineObject: Wine = try decoder.decode(Wine.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(wineObject, nil)
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    }
}
