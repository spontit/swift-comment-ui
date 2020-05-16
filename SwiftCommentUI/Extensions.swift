//
//  Extensions.swift
//  SwiftCommentUI
//
//  Created by Josh Wolff on 4/23/20.
//  Copyright © 2020 Spontit. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/2694411/text-inset-for-uitextfield
@IBDesignable
class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 6 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    @IBInspectable var insetY: CGFloat = 6 {
        didSet {
            self.layoutIfNeeded()
        }
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.insetX , dy: self.insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.insetX , dy: self.insetY)
    }
}

extension UIView {
    
    func removeBorder() {
        self.layer.borderWidth = 0
    }
    
    func giveBorder(color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func giveBorder(color: UIColor, withWidth width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func curveView() {
        self.layer.cornerRadius = Constants.CORNER_RADIUS
        self.layer.masksToBounds = true
    }
    
    func circleView(for dim: CGFloat) {
        self.layer.cornerRadius = dim / 2
        self.layer.masksToBounds = true
    }
    
}

extension String {
    func boldTaggedUsers(reply: Reply, textField: UITextField) {
        let text = textField.text
        guard text != nil && reply.taggedUser != nil else { return }
        let attributedText = NSMutableAttributedString(string: text!)
        let stringArray = text!.split(separator: " ")
        for word in stringArray {
            if word.first == "@" {
                let rangeToAdd = String(word)
                if let range = text?.range(of: rangeToAdd) {
                    attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], range: NSRange(range, in: text!))
                    textField.attributedText = attributedText
                }
            }
        }
    }
    
    func boldTaggedUsers(reply: Reply, textView: UITextView) {
        let text = textView.text
        guard text != nil && reply.taggedUser != nil else { return }
        let attributedText = NSMutableAttributedString(string: text!)
        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], range: NSRange(location: 0, length: text!.count))
        
        let stringArray = text!.split(separator: " ")
        for word in stringArray {
            if word.first == "@" {
                let rangeToAdd = String(word)
                if let range = text?.range(of: rangeToAdd) {
                    
                    attributedText.addAttribute(.link, value: rangeToAdd, range: NSRange(range, in: text!))
                    attributedText.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], range: NSRange(range, in: text!))
                    textView.linkTextAttributes = [ .foregroundColor: UIColor.black ]
                    textView.attributedText = attributedText
                }
            }
        }
    }
    
}

extension UIFont {
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    func setBoldFnc() -> UIFont {
        if self.isBold {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setItalicFnc()-> UIFont {
        if self.isItalic {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setBoldItalicFnc() -> UIFont {
        return self.setBoldFnc().setItalicFnc()
    }
    
    func detBoldFnc() -> UIFont {
        if !self.isBold {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func detItalicFnc() -> UIFont {
        if !self.isItalic {
            return self
        } else {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func SetNormalFnc() -> UIFont {
        return self.detBoldFnc().detItalicFnc()
    }
    
    func toggleBoldFnc() -> UIFont {
        if self.isBold {
            return self.detBoldFnc()
        } else {
            return self.setBoldFnc()
        }
    }
    
    func toggleItalicFnc() -> UIFont {
        if self.isItalic {
            return self.detItalicFnc()
        } else {
            return self.setItalicFnc()
        }
    }
}



extension UITableView {
    
    func basicSetUp(rowHeight : CGFloat?, allowsSelection: Bool) {
        if #available(iOS 11.0, *) {
            self.insetsContentViewsToSafeArea = true
            self.contentInsetAdjustmentBehavior = .scrollableAxes
        } else {
            // Fallback on earlier versions
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.isEditing = false
        self.rowHeight = rowHeight ?? UITableView.automaticDimension
        self.estimatedRowHeight = self.rowHeight
        
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelection = false
    }
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
    
}
