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
    var isPublicationOwner: Bool?
    var timeStamp: String?
    var commentId: String?
    
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
    
    init(userId: String?, itemId: String?, message: String?, taggedUser: [String]?, timeStamp: String?) {
        self.userId = userId
        self.itemId = itemId
        self.message = message
        self.taggedUser = taggedUser
        self.timeStamp = timeStamp
    }
    
    // MARK:- Mutating Functions
    
    mutating func setMessage(message: String?) {
        self.message = message
    }
    
    mutating func setTaggedUser(taggedUser: [String]?) {
        self.taggedUser = taggedUser
    }
    
    mutating func setTimeStamp(time: String?) {
        self.timeStamp = time
    }
}
