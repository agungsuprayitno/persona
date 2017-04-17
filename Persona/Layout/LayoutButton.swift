//
//  LayoutButton.swift
//  Persona
//
//  Created by Agung Suprayitno on 4/15/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit

class LayoutButton: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 245/255, alpha: 1)

        
        let buttonContainerView = UIView()
        buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonContainerView)
        
        buttonContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
