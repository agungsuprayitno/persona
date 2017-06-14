//
//  FriendsManager.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/14/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import CoreData

class MessageCellManager: MessageCell {
    var message : Message? {
        didSet{
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "h:mm a"
                
                timeLabel.text = dateFormater.string(from: date as Date)
            }
        }
    }
}
