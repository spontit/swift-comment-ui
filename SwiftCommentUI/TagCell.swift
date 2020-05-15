//
//  TagCell.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/17/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation
import UIKit

class TagCell: UITableViewCell {
    
    // MARK:- Public Constants
    
    static let WIDTH: CGFloat = 150
    static let HEIGHT: CGFloat = 50
    static let IMG_DIM: CGFloat = 45
    
    // MARK:- Globals
    
    var profileImageView : UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.backgroundColor = .gray
        imgVw.circleView(for: 45)
        return imgVw
    }()
    
    var usernameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    // MARK:- Internal Globals
    private let overallStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    // MARK:- Overriden Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helper Functions
    
    private func setUp() {
        self.overallStack.addArrangedSubview(self.profileImageView)
        self.overallStack.addArrangedSubview(self.usernameLabel)
        self.profileImageView.heightAnchor.constraint(equalToConstant: TagCell.IMG_DIM).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: TagCell.IMG_DIM).isActive = true
        self.contentView.addSubview(self.overallStack)
        self.overallStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.overallStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    // MARK:- Deinit
    
    deinit {
        print("Deinitializing \(Constants.TAG_CELL).")
    }
}
