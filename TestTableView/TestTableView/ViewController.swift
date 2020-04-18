//
//  ViewController.swift
//  TestTableView
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    //MARK:- Internal Globals
    private var keyboardHeight : CGFloat = 0
    private var keyboardWidth : CGFloat = 0
    private var replyTV: ReplyTableView = ReplyTableView(frame: .zero)
    private var tagTV: TagTableView = TagTableView(frame: .zero)
    var isSearching = false
    
    private let replies : [String] = ["This is 1st reply", "This is 2nd reply This is 2nd reply This is 2nd reply very long very long testing long reply", "This is 3rd reply This is 3rd reply This is 3rd reply long This is 3rd reply This is 3rd reply This is 3rd reply longThis is 3rd reply This is 3rd reply This is 3rd reply long", "This is 4th reply", "This is 5th reply"]
    private let usernames : [String] = ["zqhqhqh", "zhangqks", "zhang_q_h", "somename", "randomname"]
    private let followerNames : [String] = ["my_friend", "test_name", "username", "ones", "helloo", "lololol"]
    
    private var replyInfos: [Reply] = []
    
    private var searchedFollowers: [String] = ["my_friend", "test_name", "username", "ones", "helloo", "lololol"]
    
    private var replyField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.isHidden = true
        field.returnKeyType = .send
        return field
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
        self.replyTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.replyTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.replyTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.replyTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.view.addSubview(self.tagTV)
        
        self.replyField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingChanged)
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.replyField.resignFirstResponder()
        self.replyField.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.replyInfos.append(Reply(userId: "Qiuhao Zhang", itemId: "item", message: textField.text))
        self.replyTV.reloadData()
        textField.resignFirstResponder()
        textField.isHidden = true
        
        return true
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
        
        if textField.text?.last == "@" {
            print("last is @")
            isSearching = true
            self.tagTV.isHidden = false
        }
        if !(textField.text?.contains("@"))! {
            isSearching = false
            self.tagTV.isHidden = true
        }
        if isSearching == true {
        var index = (textField.text?.firstIndex(of: "@"))!
        var stringIndex = textField.text?.index(after: index)
        var name = textField.text?.substring(from: stringIndex!)
        print("name", name)
        self.updateSearchResult(forQueryText: name ?? "")
        self.tagTV.reloadData()
        }
    }
    
    private func updateSearchResult(forQueryText text : String) {
        var results : [String] = []
        if text == "" {
            results = self.followerNames
            self.searchedFollowers = results
            return
        }
        for name in self.followerNames {
            if name.contains(text) {
                results.append(name)
            }
        }
        self.searchedFollowers = results
        print("searchedFollowers", searchedFollowers)
    }
    
    
    //MARK:- @Objc exposed functions
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
        self.tagTV.widthAnchor.constraint(equalToConstant: TagCell.WIDTH).isActive = true
        self.tagTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * self.keyboardHeight - 50).isActive = true
        self.tagTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.tagTV.heightAnchor.constraint(equalToConstant: TagCell.HEIGHT * CGFloat(self.searchedFollowers.count)).isActive = true
        self.tagTV.isHidden = true
    }
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.replyField.isHidden = true
        self.replyField.removeFromSuperview()
    }
    
    @objc func replyPressed(_ sender: ReplyButton) {
        self.replyField.isHidden = false
        self.view.addSubview(self.replyField)
        print ("id", self.replyField.text)
        self.replyField.text = sender.username! + " "
        self.replyField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.replyField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.replyField.becomeFirstResponder()
        self.replyField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.keyboardHeight * -1).isActive = true
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.replyTV {
            return self.replyInfos.count
        } else {
            return self.searchedFollowers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.replyTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPLY_CELL, for: indexPath) as! ReplyCell
            cell.replyInfo = self.replyInfos[indexPath.row]
            cell.replyButton.username = cell.replyInfo.userId ?? " " + " "
            cell.replyButton.addTarget(self, action: #selector(replyPressed(_:)), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TAG_CELL, for: indexPath) as! TagCell
            cell.usernameLabel.text = self.searchedFollowers[indexPath.row]
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
}
