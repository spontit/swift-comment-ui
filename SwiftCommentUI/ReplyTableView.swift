//
//  ReplyTableView.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation
import UIKit

class ReplyTableView : UITableView {
    
    // MARK:- Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setUp()
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private Helper Functions
    
    private func setUp() {
        self.register(ReplyCell.self, forCellReuseIdentifier: Constants.REPLY_CELL)
        self.basicSetUp(rowHeight: nil, allowsSelection: false)
        self.keyboardDismissMode = .interactive
    }
}
