//
//  ViewController.swift
//  TestTableView
//
//  Created by Zhang Qiuhao on 4/16/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.replyTV.delegate = self
        self.replyTV.dataSource = self
        self.replyField.delegate = self
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private var keyboardHeight : CGFloat = 0
    private var keyboardWidth : CGFloat = 0
    private var replyTV: ReplyTableView = ReplyTableView(frame: .zero)
    
    private let replies : [String] = ["This is 1st reply", "This is 2nd reply This is 2nd reply This is 2nd reply very long very long testing long reply", "This is 3rd reply This is 3rd reply This is 3rd reply long This is 3rd reply This is 3rd reply This is 3rd reply longThis is 3rd reply This is 3rd reply This is 3rd reply long", "This is 4th reply", "This is 5th reply"]
    private let usernames : [String] = ["zqhqhqh", "zhangqks", "zhang_q_h", "somename", "randomname"]
    
    private var replyInfos: [Reply] = []
    
    private func setUp() {
        for i in  0..<5 {
            self.replyInfos.append(Reply(userId: usernames[i], itemId: "item", message: replies[i]))
        }
        self.replyTV.reloadData()
        self.view.addSubview(self.replyTV)
        self.replyTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.replyTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.replyTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.replyTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.view.bringSubviewToFront(self.replyTV)
    }
    
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
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
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.replyField.isHidden = true
        self.replyField.removeFromSuperview()
    }
    
    @objc func replyPressed(_ sender: Any) {
        self.replyField.isHidden = false
        self.view.addSubview(self.replyField)
        print ("id", self.replyField.text)
        self.replyField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.replyField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.replyField.becomeFirstResponder()
        self.replyField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.keyboardHeight * -1).isActive = true
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.replyInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.REPLY_CELL, for: indexPath) as! ReplyCell
        cell.replyInfo = self.replyInfos[indexPath.row]
        cell.replyButton.addTarget(self, action: #selector(replyPressed(_:)), for: .touchUpInside)
        self.replyField.text = cell.replyInfo.userId
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
