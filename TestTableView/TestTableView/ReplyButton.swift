//
//  ButtonInfo.swift
//  TestTableView
//
//  Created by Zhang Qiuhao on 4/17/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class ReplyButton : UIButton {
    var username: String?
    
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
}
