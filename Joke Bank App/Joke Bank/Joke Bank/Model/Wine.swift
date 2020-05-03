//
//  Wine.swift
//  Joke Bank
//
//  Created by Julia Debecka on 04/04/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

struct WineElement: Codable {
    let id: Int
    let name, year, grapes, country: String
    let region, wineDescription, picture: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, year, grapes, country, region
        case wineDescription = "description"
        case picture
    }
}

typealias Wine = [WineElement]
