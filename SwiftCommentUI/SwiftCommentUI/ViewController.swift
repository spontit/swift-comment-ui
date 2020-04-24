//
//  ViewController.swift
//  SwiftCommentUI
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    //MARK:- Test Data
    private let replies : [String] = ["This is 1st reply", "This is 2nd reply This is 2nd reply This is 2nd reply very long very long testing long reply", "This is 3rd reply This is 3rd reply This is 3rd reply long This is 3rd reply This is 3rd reply This is 3rd reply longThis is 3rd reply This is 3rd reply This is 3rd reply long", "This is 4th reply", "This is 5th reply"]
    private let usernames : [String] = ["zqhqhqh", "zhangqks", "zhang_q_h", "somename", "randomname"]
    private let followerNames : [String] = ["my_friend", "test_name", "username", "ones", "helloo", "lololol"]
    
    private var replyInfos: [Reply] = []
    
    private var reply: Reply!
    
    private var searchedFollowers: [String] = ["my_friend", "test_name", "username", "ones", "helloo", "lololol"]
    
    //MARK:- Internal Globals
    private var keyboardHeight : CGFloat = 0
    private var keyboardWidth : CGFloat = 0
    private var replyTV: ReplyTableView = ReplyTableView(frame: .zero)
    private var tagTV: TagTableView = TagTableView(frame: .zero)
    private var isSearching = false
    
    private var replyField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
        field.backgroundColor = .white
        field.isHidden = true
        field.returnKeyType = .send
        field.font = UIFont.systemFont(ofSize: 16)
        return field
    }()
    
    private let textFieldEmbeddedView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    //MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.replyTV.delegate = self
        self.replyTV.dataSource = self
        self.replyField.delegate = self
        self.tagTV.delegate = self
        self.tagTV.dataSource = self
        for i in  0..<5 {
            self.replyInfos.append(Reply(userId: usernames[i], itemId: "item", message: replies[i]))
        }
        self.replyTV.reloadData()
        self.view.addSubview(self.replyTV)
        if #available(iOS 11.0, *) {
            self.replyTV.leadingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
            self.replyTV.topAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            self.replyTV.trailingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        } else {
            // Fallback on earlier versions
            self.replyTV.leadingAnchor.constraint(equalTo:
                self.view.leadingAnchor, constant: 5).isActive = true
            self.replyTV.topAnchor.constraint(equalTo:
                self.view.topAnchor, constant: 20).isActive = true
            self.replyTV.trailingAnchor.constraint(equalTo:
                self.view.trailingAnchor, constant: -5).isActive = true
        }
        
        self.replyTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.view.addSubview(self.tagTV)
        self.textFieldEmbeddedView.addSubview(self.replyField)
        self.replyField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingChanged)
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.replyField.resignFirstResponder()
        self.replyField.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.reply.setMessage(message: textField.text)
        self.replyInfos.append(self.reply)
        self.replyTV.reloadData()
        textField.resignFirstResponder()
        textField.isHidden = true
        self.textFieldEmbeddedView.isHidden = true
        return true
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
        if textField.text?.last == "@" {
            print("last is @")
            self.isSearching = true
            self.tagTV.isHidden = false
        }
        if !(textField.text?.contains("@"))! {
            self.isSearching = false
            self.tagTV.isHidden = true
        }
        if self.isSearching == true {
            let index = (textField.text?.lastIndex(of: "@"))!
            let stringIndex = textField.text?.index(after: index)
            let name = textField.text?.substring(from: stringIndex!)
            self.updateSearchResult(forQueryText: name ?? "")
            self.tagTV.reloadData()
            return
        }
        
    }
    
    private func updateSearchResult(forQueryText text : String) {
        var results : [String] = []
        if text == "" {
            results = self.followerNames
            self.searchedFollowers = results
            self.tagTV.heightAnchor.constraint(equalToConstant: TagCell.HEIGHT * CGFloat(self.followerNames.count)).isActive = true
            return
        }
        for name in self.followerNames {
            if name.contains(text) {
                results.append(name)
            }
        }
        self.searchedFollowers = results
        if self.searchedFollowers.isEmpty {
            self.tagTV.isHidden = true
            self.searchedFollowers = self.followerNames
        }
        print("searchedFollowers", searchedFollowers)
    }
    
    private func setTagTV() {
        self.tagTV.widthAnchor.constraint(equalToConstant: TagCell.WIDTH).isActive = true
        self.tagTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * self.keyboardHeight - 50).isActive = true
        if #available(iOS 11.0, *) {
            self.tagTV.leadingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        } else {
            // Fallback on earlier versions
            self.tagTV.leadingAnchor.constraint(equalTo:
                self.view.leadingAnchor, constant: 10).isActive = true
        }
        self.tagTV.heightAnchor.constraint(equalToConstant: TagCell.HEIGHT * 5).isActive = true
        self.tagTV.isHidden = true
    }
    
    
    //MARK:- @Objc exposed functions
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
        self.setTagTV()
    }
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.replyField.isHidden = true
        self.textFieldEmbeddedView.isHidden = true
        self.replyField.removeFromSuperview()
    }
    
    @objc func replyPressed(_ sender: ReplyButton) {
        self.replyField.isHidden = false
        self.reply = Reply(userId: "Qiuhao Zhang", itemId: "item")
        self.reply.setTaggedUser(taggedUser: [sender.username!])
        self.textFieldEmbeddedView.addSubview(self.replyField)
        let text = "@"+sender.username! + " "
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], range: NSRange(location: 0, length: text.count - 1))
        self.replyField.attributedText = attributedText
        self.replyField.leadingAnchor.constraint(equalTo: self.textFieldEmbeddedView.leadingAnchor, constant: 5).isActive = true
        self.replyField.trailingAnchor.constraint(equalTo: self.textFieldEmbeddedView.trailingAnchor, constant: -5).isActive = true
        self.replyField.becomeFirstResponder()
        self.replyField.bottomAnchor.constraint(equalTo: self.textFieldEmbeddedView.bottomAnchor, constant: 0).isActive = true
        self.replyField.topAnchor.constraint(equalTo: self.textFieldEmbeddedView.topAnchor, constant: 0).isActive = true
        self.view.addSubview(self.textFieldEmbeddedView)
        self.textFieldEmbeddedView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        if #available(iOS 11.0, *) {
            self.textFieldEmbeddedView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            self.textFieldEmbeddedView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            self.textFieldEmbeddedView.leadingAnchor.constraint(equalTo:
                self.view.leadingAnchor, constant: 0).isActive = true
            self.textFieldEmbeddedView.trailingAnchor.constraint(equalTo:
                self.view.trailingAnchor, constant: 0).isActive = true
        }
        self.textFieldEmbeddedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.keyboardHeight * -1).isActive = true
        self.textFieldEmbeddedView.isHidden = false
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.replyTV {
            return self.replyInfos.count
        } else {
            if self.searchedFollowers.count >= 5 {
                return 5
            } else {
                return self.searchedFollowers.count
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.replyTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPLY_CELL, for: indexPath) as! ReplyCell
            cell.replyInfo = self.replyInfos[indexPath.row]
            cell.replyButton.username = cell.replyInfo.userId ?? " "
            cell.replyButton.addTarget(self, action: #selector(replyPressed(_:)), for: .touchUpInside)
            cell.replyInfo.message?.boldTaggedUsers(reply: cell.replyInfo, textView: cell.replyTextView)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TAG_CELL, for: indexPath) as! TagCell
            cell.usernameLabel.text = self.searchedFollowers[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.replyTV {
            return UITableView.automaticDimension
        } else {
            return TagCell.HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tagTV {
            let index = self.replyField.text?.lastIndex(of: "@")!
            if index != nil {
                let distance = self.replyField.text?.distance(from: self.replyField.text!.startIndex, to: index!)
                let string = self.replyField.text?.substring(to: index!)
                let stringToAdd = "@" + self.searchedFollowers[indexPath.row] + " "
                let finalString = string! + stringToAdd
                self.replyField.text = finalString
                self.reply.message = finalString
                self.reply.taggedUser!.append(self.searchedFollowers[indexPath.row])
                self.reply.message?.boldTaggedUsers(reply: self.reply, textField: self.replyField)
                self.tagTV.isHidden = true
                self.searchedFollowers = self.followerNames
            }
            
        }
    }
}
