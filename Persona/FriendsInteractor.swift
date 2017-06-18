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
            
            createMessageWithText(text: "Hello i'm Mark, nice to meet you", friend: mark as! Friend, minutesAgo: 2, context: context!)
            
            createMessageWithContext(context: context!)
            
            let bill = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context!)
            bill.setValue("Bill Gates", forKey: "name")
            bill.setValue("itunes-icon", forKey: "profileImageName")
            
            createMessageWithText(text: "Microsoft has reached something new in Tech", friend: bill as! Friend, minutesAgo: 60 * 24 * 3, context: context!)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context!)
            gandhi.setValue("Mahatma Gandhi", forKey: "name")
            gandhi.setValue("dropbox-icon", forKey: "profileImageName")
            
            createMessageWithText(text: "Love, Peace,  and JOy", friend: gandhi as! Friend, minutesAgo: 60 * 24 * 10, context: context!)
            
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
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                
                for friend in friends {
                    
                   // print(friend.name)
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        
                        let fetchedMessages = try context?.fetch(fetchRequest) as? [Message]
                        messages?.append(contentsOf: fetchedMessages!)
                        
                    }catch let err {
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})

            }
            
        }
    }
    
    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context)
        message.setValue(friend, forKey: "friend")
        message.setValue(text, forKey: "text")
        message.setValue(NSDate().addingTimeInterval(-minutesAgo * 60), forKey: "date")
        message.setValue(NSNumber(value: isSender), forKey: "isSender")
    }
    
    private func fetchFriends() -> [Friend]? {
        
        if (context != nil){
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do {
                return try context?.fetch(request) as? [Friend]
            }catch let err {
                print(err)
            }
            
        }
        
        return nil
        
    }
    
    func createMessageWithContext(context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context)
        steve.setValue("Steve Jobs", forKey: "name")
        steve.setValue("apple-2-icon", forKey: "profileImageName")
        
        createMessageWithText(text: "Good Morning", friend: steve as! Friend, minutesAgo: 2, context: context)
        createMessageWithText(text: "Hello, how are you? hope you are having a good morning", friend: steve as! Friend, minutesAgo: 2, context: context)
        createMessageWithText(text: "do you thinking to buy an apple device? we have a warranty of Apple device that will suit your needs. please make your purchase with us", friend: steve as! Friend, minutesAgo: 1, context: context)
        
        //  response message
        createMessageWithText(text: "Yes, I'm interested for buying apple device, especially iPhone 7", friend: steve as! Friend, minutesAgo: 1, context: context, isSender: true)
        
        createMessageWithText(text: "Totally understand that you want the new iPhone 7, but you'll have to wait until September for the new release. Sorry but thats just how apple likes toto things. ", friend: steve as! Friend, minutesAgo: 1, context: context)

        createMessageWithText(text: "Absolutely, I'll use my gigantic iPhone 6 Plus until Then", friend: steve as! Friend, minutesAgo: 1, context: context, isSender: true)
    }

}







