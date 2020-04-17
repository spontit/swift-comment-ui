//
//  ReplyCell.swift
//  TestTableView
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class ReplyCell: UITableViewCell {
    
    //MARK:- Internal Globals
    var replyInfo: Reply! {
        didSet {
            self.usernameLabel.text = self.replyInfo.userId
            self.replyTextView.text = self.replyInfo.message
        }
    }
    
    private var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var replyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("reply", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
    }()
    
    private var replyTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    private var profileImage : UIImageView = {
        let vw = UIImageView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.heightAnchor.constraint(equalToConstant: 50).isActive = true
        vw.widthAnchor.constraint(equalToConstant: 50).isActive = true
        vw.backgroundColor = UIColor.gray
        return vw
    }()
    
    private var timeStamp : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 30).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lbl.text = "5H"
        return lbl
    }()
    
    private var usernameStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor.gray
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    //MARK:- Overriden functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper Functions
    private func setUpLayout() {
        self.contentView.addSubview(self.profileImage)
        self.profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.profileImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.contentStack.addArrangedSubview(self.usernameStack)
        self.usernameStack.addArrangedSubview(self.usernameLabel)
        self.usernameStack.addArrangedSubview(self.timeStamp)
        self.contentStack.addArrangedSubview(self.replyTextView)
        
        self.contentView.addSubview(self.contentStack)
        self.contentView.addSubview(self.replyButton)
        self.contentStack.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 5).isActive = true
        self.contentStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.contentStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.contentStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.replyButton.topAnchor.constraint(equalTo: self.replyTextView.bottomAnchor, constant: 5).isActive = true
        self.replyButton.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 5).isActive = true
        self.replyButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
}
