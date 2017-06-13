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
    
    var message = Message() {
        didSet{
            nameLabel.text = message.friend?.name
            
            if let profileImageName = message.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message.text
            
            if let date = message.date {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "h:mm a"
                
                timeLabel.text = dateFormater.string(from: date as Date)
            }
        }
    }
    
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
//        label.text = "Friend Name"
        return label
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
//        label.text = "Here is some message for you lets write some text for you son , then request it"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
//        label.text = "12:05 pm"
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
        //containerView.backgroundColor = UIColor.red
        
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

class BaseCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.black
    }
    
}
