//
//  RobotMovieModel.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation

//// MARK: - Robots
//struct Robots: Codable {
//    let characters: [Character]
//}
//
//// MARK: - Character
//struct Character: Codable {
//    let actorName, characterName, polishCharacterName: String
//    let lines: [Line]
//}
//
//// MARK: - Line
//struct Line: Codable {
//    let id: Int
//    let line: String
//}
// MARK: - Character
struct Character: Codable {
    let actorName, characterName, polishCharacterName: String
    let lines: [Line]
}

// MARK: - Line
struct Line: Codable {
    let id: Int
    let line: String
}

typealias Characters = [Character]
