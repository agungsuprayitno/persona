//
//  PlayGround.swift
//  Persona
//
//  Created by Agung Suprayitno on 4/12/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit
import SnapKit

class PlayGround: UIViewController {
    
    let buttonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 245/255, alpha: 1)
        navigationItem.title = "Login Page"
        view.addSubview(buttonContainer)
        
        setlayoutButton()
    }
    
    func setlayoutButton() {
        buttonContainer.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(-20)
            make.right.equalTo(view).offset(-20)
        }
        setIcon()
        setButtonLogin()
        setButtonFacebook()
        setButtonGoogle()

    }
    
    let imageIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "itunes-icon")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = true
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    let buttonLogin: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(red: 0/255, green: 134/255, blue: 241/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login with Your Account", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
        return button
    }()
    
    let buttonFacebook: UIButton = {
       let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login with Facebook", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(actionFacebook), for: .touchUpInside)
        return button
    }()

    let buttonGoogle: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login with Google", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(actionGoogle), for: .touchUpInside)
        return button
    }()

    func setIcon() {
        view.addSubview(imageIcon)
        
        imageIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(buttonContainer).offset(20)
            make.centerX.equalTo(buttonContainer)
            make.width.height.equalTo(128)
        }
    }
    
    func setButtonLogin() {
        buttonContainer.addSubview(buttonLogin)
        buttonLogin.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageIcon).offset(150)
            make.left.equalTo(buttonContainer).offset(0)
            make.right.equalTo(buttonContainer).offset(0)
            make.width.height.equalTo(50)
        }
    }

    func setButtonFacebook() {
        buttonContainer.addSubview(buttonFacebook)
        buttonFacebook.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(buttonLogin).offset(60)
            make.left.equalTo(buttonContainer).offset(0)
            make.right.equalTo(buttonContainer).offset(0)
            make.width.height.equalTo(50)
        }
    }
    
    func setButtonGoogle() {
        buttonContainer.addSubview(buttonGoogle)
        buttonGoogle.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(buttonFacebook).offset(60)
            make.left.equalTo(buttonContainer).offset(0)
            make.right.equalTo(buttonContainer).offset(0)
            make.width.height.equalTo(50)
        }
    }
    
    func actionLogin() {
        
        self.dismiss(animated: true, completion: nil)
        
        let loginPage = LoginFirebase()
        let navController = UINavigationController(rootViewController: loginPage)
        present(navController, animated: true, completion: nil)
        
        
    }
    
    func actionFacebook() {
        
        print("Login Facebook Action")
        
    }
    
    func actionGoogle() {
        print("Login Google Action")
    }


}
