//
//  Thought.swift
//  RNDM
//
//  Created by Julia Debecka on 15/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import Foundation
import Firebase
class Thought {
    
    private(set) var category: String
    var numComments: Int
    private(set) var thoughtTxt: String
    var numLikes: Int
    private(set) var username: String
    
    var documentID: String = {
        let doc = ""
        return doc
    }()
    var timestamp: FieldValue = {
        let value = FieldValue.serverTimestamp()
        return value
    }()
    
    var date: Date = {
        let date = Date()
        return date
    }()
    
    init(category: String, numComments: Int, thoughtTxt: String, numLikes: Int, timestamp: FieldValue, username: String) {
        self.category = category
        self.numComments = numComments
        self.thoughtTxt = thoughtTxt
        self.numLikes = numLikes
        self.timestamp = timestamp
        self.username = username
    }
    
    init(category: String, numComments: Int, thoughtTxt: String, numLikes: Int, date: Date, username: String, documentID: String) {
        self.category = category
        self.numComments = numComments
        self.thoughtTxt = thoughtTxt
        self.numLikes = numLikes
        self.date = date
        self.username = username
    }
    
    
    func returnData() -> [String : Any] {
        return ["category" : category,
                "numComments" : numComments,
                "numLikes" : numLikes,
                "thoughtTxt" : thoughtTxt,
                "timestamp" : timestamp,
                "username" : username
                ]
    }
}
