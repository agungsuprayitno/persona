//
//  FriendView.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/12/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import LBTAComponents

class MessageCell: BaseCell {
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        return imageView
    }()
    
    let dividerLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let hasReadImageView : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "apple-2-icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private func setupContainerView(){
        let containerView = UIView()
        
        addSubview(containerView)
        addSubview(nameLabel)
        addSubview(messageLabel)
        addSubview(timeLabel)
        addSubview(hasReadImageView)
        
        containerView.anchor(profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: profileImageView.bottomAnchor, right: self.rightAnchor, topConstant: 4 , leftConstant: 12, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        nameLabel.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: timeLabel.leftAnchor, topConstant: 5 , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        messageLabel.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: hasReadImageView.leftAnchor, topConstant: 5 , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        timeLabel.anchor(nameLabel.topAnchor, left: nil, bottom: nil, right: containerView.rightAnchor, topConstant: 0 , leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        hasReadImageView.anchor(messageLabel.topAnchor, left: messageLabel.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0 , leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
    }
    
    override func setupViews() {
        //        backgroundColor = UIColor.blue
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        profileImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 16 , leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 68, heightConstant: 68)
        
        dividerLineView.anchor(nil, left: profileImageView.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0 , leftConstant: 0, bottomConstant: 2, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        setupContainerView()
        
    }
    
}
