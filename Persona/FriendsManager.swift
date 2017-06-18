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
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * secondInDays {
                    dateFormater.dateFormat = "MM/dd/yy"
                }else if elapsedTimeInSeconds > secondInDays {
                    dateFormater.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormater.string(from: date as Date)
            }
        }
    }
}
