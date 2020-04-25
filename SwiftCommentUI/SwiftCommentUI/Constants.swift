//
//  Constants.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let REPLY_CELL = "ReplyCell"
    static let TAG_CELL = "TagCell"
    static let REPLY_BUTTON = "ReplyButton"
    
    static let CORNER_RADIUS : CGFloat = 5.0
}

extension UIBarButtonItem {
    static func getCancelButton(target: Any, selector: Selector) -> UIBarButtonItem {
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: target, action: selector)
        cancelBtn.tintColor = UIColor.white
        return cancelBtn
    }
    
//    static func getSaveButton(target: Any, selector: Selector) -> UIBarButtonItem {
//        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: target, action: selector)
//        saveButton.tintColor = Constants.MAIN_COLOR_BLUE
//        return saveButton
//    }
//    
//    static func getDoneButton(target: Any, selector: Selector) -> UIBarButtonItem {
//        let saveButton = UIBarButtonItem.init(title: "Done", style: .plain, target: target, action: selector)
//        saveButton.tintColor = Constants.MAIN_COLOR_BLUE
//        return saveButton
//    }
}
