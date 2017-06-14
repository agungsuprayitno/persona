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
    
    func clearData() {
        if (context != nil){
            do {
                
                let entityNames = ["Friend", "Message"]
            
                for entityName in entityNames {
                
                    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
                    let objects = try context?.fetch(fetchRequest)
                
                    for object in objects! {
                        context?.delete(object)
                    }
        
                }
                
                try context?.save()
                
            }catch let err {
                print(err)
            }
            

        }
    }
    
    func setupData(){
        
        clearData() // clear all data and re-create data on collectionView
        
        if (context != nil) {
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context!)
            mark.setValue("Mark Zuckerberg", forKey: "name")
            mark.setValue("chrome-icon", forKey: "profileImageName")
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context!)
            message.setValue(mark, forKey: "friend")
            message.setValue("Hello i'm Mark, nice to meet you", forKey: "text")
            message.setValue(NSDate(), forKey: "date")
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context!)
            steve.setValue("Steve Jobs", forKey: "name")
            steve.setValue("apple-2-icon", forKey: "profileImageName")
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context!)
            messageSteve.setValue(steve, forKey: "friend")
            messageSteve.setValue("Apple has made an Big Revolution", forKey: "text")
            messageSteve.setValue(NSDate(), forKey: "date")
            
            do {
                try(context?.save())
            }catch let err {
                print(err)
            }
            
        }
        loadData()
        
    }
    
    func loadData() {
        if (context != nil){
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Message")
            
            do {
               messages = try context?.fetch(fetchRequest) as! [Message]?
            }catch let err {
                print(err)
            }
            
        }
    }

}







