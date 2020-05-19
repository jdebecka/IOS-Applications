//
//  ReadJson.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

struct RobotsMovieRepository {
    static func getMovieResources(_ completion: @escaping ((Characters) -> Void)) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let path = Bundle.main.path(forResource: "Robots", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    let robots: Characters = try decoder.decode(Characters.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(robots)
                    }
                }catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }
    }
}
