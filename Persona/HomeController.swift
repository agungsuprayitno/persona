//
//  LoginFirebase.swift
//  Persona
//
//  Created by Agung Suprayitno on 4/16/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 245/255, alpha: 1)
        navigationItem.title = "Please Login"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backtoLogin))

        setupInputsContainerView()
    }
    
       func setupInputsContainerView() {
        print("asdasd");
        
    }
    
    func backtoLogin() {
        
        self.dismiss(animated: true, completion: nil)
//        
//        let homePage = PlayGround()
//        let navController = UINavigationController(rootViewController: homePage)
//        present(navController, animated: true, completion: nil)
    }
    
}
