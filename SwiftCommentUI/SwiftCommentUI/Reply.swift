//
//  Reply.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation

struct Reply {
    
    // MARK:- Attributes
    
    var userId: String?
    var itemId: String?
    var message: String?
    var taggedUser: [String]?
    
    // MARK:- Initialization
    
    init(userId: String?, itemId: String?) {
        self.userId = userId
        self.itemId = itemId
    }
    
    init(userId: String?, itemId: String?, message: String?) {
        self.userId = userId
        self.itemId = itemId
        self.message = message
    }
    
    init(userId: String?, itemId: String?, message: String?, taggedUser: [String]?) {
        self.userId = userId
        self.itemId = itemId
        self.message = message
        self.taggedUser = taggedUser
    }
    
    // MARK:- Mutating Functions
    
    mutating func setMessage(message: String?) {
        self.message = message
    }
    
    mutating func setTaggedUser(taggedUser: [String]?) {
        self.taggedUser = taggedUser
    }
}
