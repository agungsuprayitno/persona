//
//  FriendsControllerHelper.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/12/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit

extension FriendsController {
    
    func setupData(){
        
            let mark = Friend()
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "chrome-icon"
        
            let message = Message()
            message.friend = mark
            message.text = "Hello i'm Mark, nice to meet you"
            message.date = NSDate()
            
            messages = [message]

        
        
    }

}
