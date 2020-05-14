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
    private let replies : [String] = ["I think this is a good idea", "@casey_k Check this out!", "@qiuhao_zhang @casey_k Wow this is so cool!", "This is gonna be exciting, looking forward to it!", "@lisaaaa Look at this!"]
    private let usernames : [String] = ["spontit_channel", "jacky12", "casey_k", "Kate046", "Mr_Nick"]
    private let followerNames : [String] = ["casey_k", "samlee393", "bestjoe", "Kate046", "3_yvette", "Johnzzz"]
    
    private var replyInfos: [Reply] = []
    
    private var reply: Reply = Reply(userId: "qiuhao_zhang", itemId: "item")
    
    private var searchedFollowers: [String] = ["jacky12", "samlee393", "bestjoe", "Kate046", "3_yvette", "Mr_Nick"]
    private let profilePictures: [UIImage] = [UIImage(imageLiteralResourceName: "Profile1"),
                                              UIImage(imageLiteralResourceName: "Profile2"),
                                              UIImage(imageLiteralResourceName: "Profile3"),
                                              UIImage(imageLiteralResourceName: "Profile4"),
                                              UIImage(imageLiteralResourceName: "Profile5"),]
    private let followerProfilePictures: [UIImage] = [UIImage(imageLiteralResourceName: "Profile1"),
    UIImage(imageLiteralResourceName: "Profile8"),
    UIImage(imageLiteralResourceName: "Profile7"),
    UIImage(imageLiteralResourceName: "Profile4"),
    UIImage(imageLiteralResourceName: "Profile9"),
    UIImage(imageLiteralResourceName: "Profile5")]
    private let numberOfLikes = [10,4,5,2,1]
    
    //MARK:- Internal Globals
    private var keyboardHeight : CGFloat = 0
    private var keyboardWidth : CGFloat = 0
    private var replyTV: ReplyTableView = ReplyTableView(frame: .zero)
    private var tagTV: TagTableView = TagTableView(frame: .zero)
    private var isSearching = false
    private var textFieldBottomConstraint1 : NSLayoutConstraint!
    private var textFieldBottomConstraint2 : NSLayoutConstraint!
    private var replyTVBottomConstraint1 : NSLayoutConstraint!
    private var replyTVBottomConstraint2 : NSLayoutConstraint!
    
    private var replyField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
        field.backgroundColor = .white
        field.returnKeyType = .send
        field.font = UIFont.systemFont(ofSize: 16)
        field.curveView()
        field.giveBorder(color: .lightGray)
        field.placeholder = "Add your comment here"
        return field
    }()
    
    private let textFieldEmbeddedView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    //MARK:- Overriden Functions
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewDidLoad()
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.replyField.becomeFirstResponder()
        self.replyField.resignFirstResponder()
    }
    
    //MARK:- Helper Functions
    
    private func setUp() {
        self.view.backgroundColor = .white
        self.replyTV.delegate = self
        self.replyTV.dataSource = self
        self.replyField.delegate = self
        self.tagTV.delegate = self
        self.tagTV.dataSource = self
        self.replyInfos.append(Reply(userId: usernames[0], itemId: "item", message: replies[0], taggedUser: [], timeStamp: "1 Hour"))
        self.replyInfos.append(Reply(userId: usernames[1], itemId: "item", message: replies[1], taggedUser: ["casey_k"], timeStamp: "50 min"))
        self.replyInfos.append(Reply(userId: usernames[2], itemId: "item", message: replies[2], taggedUser: ["qiuhao_zhang", "casey_k"], timeStamp: "40 min"))
        self.replyInfos.append(Reply(userId: usernames[3], itemId: "item", message: replies[3], taggedUser: [], timeStamp: "30 min"))
        self.replyInfos.append(Reply(userId: usernames[4], itemId: "item", message: replies[4], taggedUser: ["lisaaaa"], timeStamp: "10 min"))
        for i in 0..<self.replyInfos.count {
            self.replyInfos[i].likeCount = self.numberOfLikes[i]
        }
        
        self.replyTV.reloadData()
        self.view.addSubview(self.replyTV)
        if #available(iOS 11.0, *) {
            self.replyTV.leadingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            self.replyTV.topAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            self.replyTV.trailingAnchor.constraint(equalTo:
                self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        } else {
            // Fallback on earlier versions
            self.replyTV.leadingAnchor.constraint(equalTo:
                self.view.leadingAnchor, constant: 5).isActive = true
            self.replyTV.topAnchor.constraint(equalTo:
                self.view.topAnchor, constant: 20).isActive = true
            self.replyTV.trailingAnchor.constraint(equalTo:
                self.view.trailingAnchor, constant: -5).isActive = true
        }
        
        self.textFieldEmbeddedView.addSubview(self.replyField)
        self.replyField.leadingAnchor.constraint(equalTo: self.textFieldEmbeddedView.leadingAnchor, constant: 7).isActive = true
        self.replyField.trailingAnchor.constraint(equalTo: self.textFieldEmbeddedView.trailingAnchor, constant: -7).isActive = true
        self.replyField.becomeFirstResponder()
        self.replyField.bottomAnchor.constraint(equalTo: self.textFieldEmbeddedView.bottomAnchor, constant: 0).isActive = true
        self.replyField.topAnchor.constraint(equalTo: self.textFieldEmbeddedView.topAnchor, constant: 0).isActive = true
        self.replyField.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: .editingChanged)
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
        self.textFieldBottomConstraint1 = self.textFieldEmbeddedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        self.textFieldBottomConstraint1.isActive = true
        
        self.replyTVBottomConstraint1 = self.replyTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70)
        self.replyTVBottomConstraint1.isActive = true
        self.view.addSubview(self.tagTV)
        self.textFieldEmbeddedView.addSubview(self.replyField)
        self.replyField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingChanged)
    }
    
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.replyField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            self.reply.setMessage(message: textField.text)
            self.reply.setTimeStamp(time: "1 min")
            self.replyInfos.append(self.reply)
            self.replyTV.reloadData()
            
        }

        textField.resignFirstResponder()
        textField.text = ""
        self.textFieldBottomConstraint2.isActive = false
        self.textFieldBottomConstraint1.isActive = true
        self.replyTVBottomConstraint2.isActive = false
        self.replyTVBottomConstraint1.isActive = true
        self.replyTV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.replyTV.scrollToRow(at: IndexPath(row: self.replyInfos.count - 1, section: 0), at: .bottom, animated: true)
        return true
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
    }
    
    private func setTagTV() {
        self.tagTV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.tagTV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        self.tagTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * self.keyboardHeight - 50).isActive = true
        if #available(iOS 11.0, *) {
            self.tagTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
            self.tagTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: self.keyboardHeight * -1).isActive = true
        } else {
            // Fallback on earlier versions
            self.tagTV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
            self.tagTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.keyboardHeight * -1).isActive = true
        }
        self.tagTV.isHidden = true
    }
    
    
    //MARK:- @Objc exposed functions
    @objc func profileImageTouched(_ recognizer: UITapGestureRecognizer) {
        print ("touched")
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.last == "@" {
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
        }
            
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        if text != nil {
            let textArray = text!.split(separator: " ")
            for word in textArray {
                if word.first == "@" {
                    if self.reply.taggedUser != nil {
                        self.reply.taggedUser!.append(String(word))
                    } else {
                        self.reply.setTaggedUser(taggedUser: [String(word)])
                    }
                    self.reply.message?.boldTaggedUsers(reply: self.reply, textField: textField)
                }
            }

        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
        self.setTagTV()
        self.textFieldBottomConstraint2 = self.textFieldEmbeddedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.keyboardHeight * -1)
        self.replyTVBottomConstraint2 = self.replyTV.bottomAnchor.constraint(equalTo: self.textFieldEmbeddedView.topAnchor, constant: -5)
        self.textFieldBottomConstraint1.isActive = false
        self.textFieldBottomConstraint2.isActive = true
        self.replyTV.setBottomInset(to: keyboardHeight)
        
        self.view.setNeedsLayout()
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.textFieldBottomConstraint2.isActive = false
        self.textFieldBottomConstraint1.isActive = true
        self.replyTV.setBottomInset(to: 0.0)
        
        self.replyField.text = ""
        self.replyTV.setBottomInset(to: 0.0)
        print("keyboard hide")
    }
    
    @objc func replyPressed(_ sender: ReplyButton) {
        if self.textFieldBottomConstraint1.isActive == true {
            self.replyField.becomeFirstResponder()
            self.reply.setTaggedUser(taggedUser: [sender.username!])
            self.replyTV.scrollToRow(at: IndexPath(row: sender.rowNumber ?? 0, section: 0), at: .bottom, animated: true)
            self.replyField.becomeFirstResponder()
            self.view.setNeedsLayout()
            let text = "@"+sender.username! + " "
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], range: NSRange(location: 0, length: text.count - 1))
            self.replyField.attributedText = attributedText
            
        }
        
    }
    
    @objc func likePressed(_ sender: ReplyButton) {
        if sender.currentImage == UIImage(imageLiteralResourceName: "Like") {
            sender.setImage(UIImage(imageLiteralResourceName: "Liked"), for: .normal)
            self.replyInfos[sender.rowNumber!].likeCount! += 1
            self.replyTV.reloadData()
        } else {
            sender.setImage(UIImage(imageLiteralResourceName: "Like"), for: .normal)
            self.replyInfos[sender.rowNumber!].likeCount! -= 1
            self.replyTV.reloadData()
        }
        
    }
    
    //MARK:- Deinit
    deinit {
        
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
            cell.replyButton.username = cell.replyInfo.userId ?? " "
            cell.replyButton.setRowNumber(number: indexPath.row)
            cell.replyButton.addTarget(self, action: #selector(replyPressed(_:)), for: .touchUpInside)
            cell.likeButton.addTarget(self, action: #selector(likePressed(_:)), for: .touchUpInside)
            cell.replyInfo.message?.boldTaggedUsers(reply: cell.replyInfo, textView: cell.replyTextView)
            cell.profileImage.image = self.profilePictures[indexPath.row % 5]
            cell.profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileImageTouched(_:))))
            cell.replyInfo.message?.boldTaggedUsers(reply: cell.replyInfo, textView: cell.replyTextView)
            cell.timeStamp.text = cell.replyInfo.timeStamp
            cell.likeButton.setRowNumber(number: indexPath.row)
            cell.likeCount.text = String(cell.replyInfo.likeCount!)
            if cell.replyInfo.userId == "qiuhao_zhang" {
                cell.profileImage.image = UIImage(imageLiteralResourceName: "Profile6")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TAG_CELL, for: indexPath) as! TagCell
            cell.usernameLabel.text = self.searchedFollowers[indexPath.row]
            cell.profileImageView.image = self.followerProfilePictures[indexPath.row]
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
            let index = self.replyField.text?.lastIndex(of: "@")
            if index != nil {
                let string = self.replyField.text?.substring(to: index!)
                let stringToAdd = "@" + self.searchedFollowers[indexPath.row] + " "
                var finalString = ""
                if index != self.replyField.text?.startIndex {
                    finalString = string! + stringToAdd
                } else {
                    finalString = stringToAdd
                }
                self.replyField.text = finalString
                self.reply.message = finalString
                if self.reply.taggedUser != nil {
                    self.reply.taggedUser!.append(self.searchedFollowers[indexPath.row])
                } else {
                    self.reply.setTaggedUser(taggedUser: [self.searchedFollowers[indexPath.row]])
                }
                
                self.reply.message?.boldTaggedUsers(reply: self.reply, textField: self.replyField)
                self.tagTV.isHidden = true
                self.searchedFollowers = self.followerNames
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == self.replyTV {
            if self.replyInfos[indexPath.row].userId == "Qiuhao Zhang" {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if self.replyInfos[indexPath.row].userId == "Qiuhao Zhang" {
            if editingStyle == .delete {
                self.replyInfos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
}
