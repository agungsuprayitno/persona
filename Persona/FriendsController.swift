//
//  FriendsController.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/5/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents
import CoreData

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
//    var messages: [Message]?
    
    lazy var fetchedResultController: NSFetchedResultsController<Friend> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc as! NSFetchedResultsController<Friend>
    }()

    var blockOperations = [BlockOperation]()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .insert {
            
            blockOperations.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: ([newIndexPath! as IndexPath]))
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            for operation in self.blockOperations {
                operation.start()
            }
        }, completion: { (completed) in
            let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
            let indexPath = NSIndexPath(item: lastItem, section: 0)
            
            self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        })
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(MessageCellManager.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
        
        do {
            try fetchedResultController.performFetch()
        } catch let err {
            print(err)
        }

    }
    
    func logout() {
        let loginController = LoginController()
        self.present(loginController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCellManager
        
        let friend = fetchedResultController.object(at: indexPath) 
        
        cell.message = friend.lastMessage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        let friend = fetchedResultController.object(at: indexPath)
        controller.friend = friend
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

























