//
//  ChatLogView.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/19/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import LBTAComponents

class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.text = "Sample Text"
        
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        //        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")?.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ChatLogMessageCell.grayBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        textBubbleView.addSubview(bubbleImageView)
        
        
        profileImageView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0 , leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 30, heightConstant: 30)
        
        bubbleImageView.anchor(textBubbleView.topAnchor, left: textBubbleView.leftAnchor, bottom: textBubbleView.bottomAnchor, right: textBubbleView.rightAnchor, topConstant: 0 , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}
