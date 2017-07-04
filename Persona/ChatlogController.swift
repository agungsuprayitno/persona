//
//  chatlogManager.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/14/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import Foundation
import UIKit
import LBTAComponents
import CoreData

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    private let cellId = "celId"
    
    var friend: Friend? {
        
        didSet {
            navigationItem.title = friend?.name
        }
    }
    
    let messageInputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.init(r: 0, g: 124, b: 247), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        return button
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 1)
        return view
    }()
    
    func handleSendButton() {
        
        _ = FriendsController.createMessageWithText(text: inputTextField.text!, friend: friend!, minutesAgo: 0, context: context!, isSender: true)
        
        do {
            
            try context?.save()
            inputTextField.text = nil

        } catch let err {
            print(err)
        }
    }

    func simulate() {
        
        _ = FriendsController.createMessageWithText(text: "Here is a text message that was sent a few minutes ago...", friend: friend!, minutesAgo: 1, context: context!)
        
        do {
            
            try context?.save()

        } catch let err {
            print(err)
        }
    }

    
    var constraintBottom: NSLayoutConstraint?
    
    lazy var fetchedResultController: NSFetchedResultsController<Message> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "friend.name = %@", self.friend!.name!)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc as! NSFetchedResultsController<Message>
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
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        do {
            try fetchedResultController.performFetch()
        } catch let err {
            print(err)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .plain, target: self, action: #selector(simulate))
        
        tabBarController?.tabBar.isHidden = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(messageInputContainerView)
        messageInputContainerView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 48)

        constraintBottom = NSLayoutConstraint (item: messageInputContainerView,
                                               attribute: .bottom,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        view.addConstraint(constraintBottom!)
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatLogController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        
        let message = fetchedResultController.object(at: indexPath) 
        
        cell.messageTextView.text = message.text
        
        if let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            
            cell.profileImageView.image = UIImage(named: profileImageName)
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if message.isSender == false {
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 6)
                
                cell.profileImageView.isHidden = false
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage
                
            }else{
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                
                cell.profileImageView.isHidden = true
                cell.bubbleImageView.tintColor = UIColor.init(r: 0, g: 124, b: 247)
                cell.messageTextView.textColor = UIColor.white
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage
            }
        
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let message = fetchedResultController.object(at: indexPath)
        
        if let messageText = message.text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
            
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
}












