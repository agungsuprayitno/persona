//
//  ChatLogInteractor.swift
//  Persona
//
//  Created by Agung Suprayitno on 6/19/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import Foundation
import UIKit

extension ChatLogController {
    
    func setupInputComponents(){
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(borderView)
        
        inputTextField.anchor(messageInputContainerView.topAnchor, left: messageInputContainerView.leftAnchor, bottom: messageInputContainerView.bottomAnchor, right: sendButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        sendButton.anchor(messageInputContainerView.topAnchor, left: inputTextField.rightAnchor, bottom: messageInputContainerView.bottomAnchor, right: messageInputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 0)
        
        borderView.anchor(messageInputContainerView.topAnchor, left: messageInputContainerView.leftAnchor, bottom: nil, right: messageInputContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            constraintBottom?.constant = isKeyboardShowing ? -keyboardSize!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
                    let indexPath = NSIndexPath(item: lastItem, section: 0)
                    
                    self.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)

                }
                
            })
        }
    }


}
