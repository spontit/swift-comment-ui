//
//  tagTableView.swift
//  TestTableView
//
//  Created by Zhang Qiuhao on 4/17/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class TagTableView : UITableView {
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
    
    private func setUp() {
        self.register(TagCell.self, forCellReuseIdentifier: Constants.TAG_CELL)
        self.insetsContentViewsToSafeArea = true
        self.contentInsetAdjustmentBehavior = .scrollableAxes
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.isEditing = false
        self.rowHeight = TagCell.HEIGHT
        
        self.allowsSelection = true
        self.allowsMultipleSelection = false
    }
}
