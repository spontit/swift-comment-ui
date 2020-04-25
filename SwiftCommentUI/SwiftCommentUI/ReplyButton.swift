//
//  ButtonInfo.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/17/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation
import UIKit

class ReplyButton : UIButton {
    
    // MARK:- Data
    
    var username: String?
    var rowNumber: Int?
    
    // MARK:- Initialization
    
    init() {
        super.init(frame: .zero)
    }
    
    init(name: String) {
        super.init(frame: .zero)
        self.username = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRowNumber(number: Int?) {
        self.rowNumber = number
    }
    
    // MARK:- Deinit
    
    deinit {
        print("Deinitializating \(Constants.REPLY_BUTTON).")
    }
}
