//
//  ViewController.swift
//  Persona
//
//  Created by Agung Suprayitno on 4/7/17.
//  Copyright © 2017 Agung Suprayitno. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 245/255, alpha: 1)
        
        setUI()
    }
    
    func setUI() {
        let image = UIImage(named: "corvette")
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.4)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill

        view.addSubview(imageView)
        
        let buttonView = ButtonView()
        buttonView.setLayout(y: imageView.frame.maxY + 40, x: view.center.x - 125)
        view.addSubview(buttonView)
    }
    
}

class ButtonView: UIView {
    
    var buttonLogin = UIButton()
    var buttonGoogle = UIButton()
    var buttonFaceBook = UIButton()
    var buttonTwitter = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    func setLayout(y: CGFloat, x: CGFloat){
        
        buttonLogin.setTitle("Login with your Account", for: .normal)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.frame = CGRect(x: x, y: y, width: 250, height: 50)
        buttonLogin.setTitleColor(UIColor.white, for: .normal)
        buttonLogin.addTarget(self, action: #selector(self.loginAccount), for: .touchUpInside)
        buttonLogin.backgroundColor = UIColor(red: 46/255, green: 141/255, blue: 237/255, alpha: 1)
        buttonLogin.layer.cornerRadius = 5
        buttonLogin.layer.borderWidth = 1
        addSubview(buttonLogin)

        buttonFaceBook.setTitle("Login with Facebook", for: .normal)
        buttonFaceBook.frame = CGRect(x: x, y: buttonLogin.frame.maxY + 10, width: 250, height: 50)
        buttonFaceBook.setTitleColor(UIColor.white, for: .normal)
        buttonFaceBook.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        buttonFaceBook.layer.cornerRadius = 5
        buttonFaceBook.layer.borderWidth = 1
        addSubview(buttonFaceBook)
        
        buttonGoogle.setTitle("Login with Google", for: .normal)
        buttonGoogle.translatesAutoresizingMaskIntoConstraints = false
        buttonGoogle.frame = CGRect(x: x, y: buttonFaceBook.frame.maxY + 10, width: 250, height: 50)
        buttonGoogle.setTitleColor(UIColor.gray, for: .normal)
        buttonGoogle.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        buttonGoogle.layer.cornerRadius = 5
        buttonGoogle.layer.borderWidth = 1
        addSubview(buttonGoogle)
        
        buttonTwitter.setTitle("Login with Twitter", for: .normal)
        buttonTwitter.frame = CGRect(x: x, y: buttonGoogle.frame.maxY + 10, width: 250, height: 50)
        buttonTwitter.setTitleColor(UIColor.white, for: .normal)
        buttonTwitter.backgroundColor = UIColor(red: 255/255, green: 173/255, blue: 31/255, alpha: 1)
        buttonTwitter.layer.cornerRadius = 5
        buttonTwitter.layer.borderWidth = 1
        addSubview(buttonTwitter)
    }
    
    func loginAccount() {
        print("Success")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//class DescriptionView: UIView {
//    
//    var logo: UIImage!
//    var name: String!
//    var content: String!
//    
//    init(frame: CGRect, logo: UIImage, name: String, content: String) {
//        super.init(frame: frame)
//        self.backgroundColor = UIColor.white
//        self.logo = logo
//        self.name = name
//        self.content = content
//        setLayout()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setLayout() {
//        let logoView = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
//        logoView.image = logo
//        
//    }
//    
//}


