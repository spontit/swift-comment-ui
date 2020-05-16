//
//  ReplyCell.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import Foundation
import UIKit

class ReplyCell: UITableViewCell {
    
    // MARK:- Internal Globals
    
    private var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    
    private var bottomStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private var spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameContentEmbeddedView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.curveView()
        return view
    }()
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor.gray
        stack.giveBorder(color: .black)
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    // MARK:- Globals
    
    var timeStamp : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lbl.text = "1 min"
        return lbl
    }()
    
    var likeCount : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        lbl.text = "0"
        return lbl
    }()
    
    var profileImage : UIImageView = {
        let vw = UIImageView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.heightAnchor.constraint(equalToConstant: 50).isActive = true
        vw.widthAnchor.constraint(equalToConstant: 50).isActive = true
        vw.backgroundColor = UIColor.gray
        vw.circleView(for: 50)
        vw.isUserInteractionEnabled = true
        return vw
    }()
    
    var replyButton: ReplyButton = {
        let btn = ReplyButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Reply", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btn
    }()
    
    var likeButton: ReplyButton = {
        let btn = ReplyButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(imageLiteralResourceName: "Like"), for: .normal)
        btn.setImage(UIImage(imageLiteralResourceName: "Liked"), for: .selected)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btn
    }()
    
    var replyTextView : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    // MARK:- Data
    
    var replyInfo: Reply! {
        didSet {
            self.usernameLabel.text = self.replyInfo.userId
            self.replyTextView.text = self.replyInfo.message
        }
    }
    
    // MARK:- Overriden Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helper Functions
    
    private func setUpLayout() {
        self.contentView.addSubview(self.profileImage)
        self.profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.profileImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.nameContentEmbeddedView.addSubview(self.usernameLabel)
        self.nameContentEmbeddedView.addSubview(self.replyTextView)
        self.bottomStack.addArrangedSubview(self.timeStamp)
        self.bottomStack.addArrangedSubview(self.likeButton)
        self.bottomStack.addArrangedSubview(self.likeCount)
        self.bottomStack.addArrangedSubview(self.replyButton)
        self.bottomStack.addArrangedSubview(self.spacingView)
        self.contentStack.addArrangedSubview(self.nameContentEmbeddedView)
        self.contentStack.addArrangedSubview(self.bottomStack)
        
        self.contentView.addSubview(self.contentStack)
        self.usernameLabel.topAnchor.constraint(equalTo: self.nameContentEmbeddedView.topAnchor, constant: 5).isActive = true
        self.usernameLabel.leadingAnchor.constraint(equalTo: self.nameContentEmbeddedView.leadingAnchor, constant: 5).isActive = true
        self.usernameLabel.trailingAnchor.constraint(equalTo: self.nameContentEmbeddedView.trailingAnchor, constant: -5).isActive = true
        self.replyTextView.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 5).isActive = true
        self.replyTextView.leftAnchor.constraint(equalTo: self.usernameLabel.leftAnchor).isActive = true
        self.replyTextView.rightAnchor.constraint(equalTo: self.usernameLabel.rightAnchor).isActive = true
        self.replyTextView.bottomAnchor.constraint(equalTo: self.bottomStack.topAnchor, constant: -15).isActive = true
        
        self.contentStack.leadingAnchor.constraint(equalTo: self.profileImage.trailingAnchor, constant: 5).isActive = true
        self.contentStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.contentStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.contentStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    
    // MARK:- Deinit
    
    deinit {
        print("Deinitializing \(Constants.REPLY_CELL).")
    }
}
