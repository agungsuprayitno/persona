//
//  FriendsControllerHelper.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/12/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func setupData(){
        
        let entityFriend = NSEntityDescription.entity(forEntityName: "Friend", in: context)!
        let entityMessage = NSEntityDescription.entity(forEntityName: "Message", in: context)!
        
        let mark = NSManagedObject(entity: entityFriend, insertInto: context)
        mark.setValue("Mark Zuckerberg", forKey: "name")
        mark.setValue("chrome-icon", forKey: "profileImageName")
        
        let message = NSManagedObject(entity: entityMessage, insertInto: context)
        message.setValue(mark, forKey: "friend")
        message.setValue("Hello i'm Mark, nice to meet you", forKey: "text")
        message.setValue(NSDate(), forKey: "date")
        
        let steve = NSManagedObject(entity: entityFriend, insertInto: context)
        steve.setValue("Steve Jobs", forKey: "name")
        steve.setValue("apple-2-icon", forKey: "profileImageName")
        
        let messageSteve = NSManagedObject(entity: entityMessage, insertInto: context)
        messageSteve.setValue(steve, forKey: "friend")
        messageSteve.setValue("Apple has made an Big Revolution", forKey: "text")
        messageSteve.setValue(NSDate(), forKey: "date")

                
        messages = [message as! Message, messageSteve as! Message]

        
        
    }

}
