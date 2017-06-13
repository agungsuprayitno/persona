
import UIKit
import SnapKit
import LBTAComponents
import TRON
import SwiftyJSON

class LoginController: UIViewController{
    
    let containerViews: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let scrolltoView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        return scrollView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "itunes-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 139, b: 224)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    
    class Home: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Data", json)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error", json)
        }
    }
    let tron = TRON(baseURL: "http://localhost")
    
    func handleLogin() {
        
        let request: APIRequest<Home, JSONError> = tron.request("/oauth/token")
        request.method = .post
        request.parameters = [
            "grant_type": "password",
            "client_id": 1,
            "client_secret": "1gntPT5zCsLvWUnr3VHACr2AHHKGBnWsJn6SRW5D",
            "username": emailTextField.text!,
            "password": passwordTextField.text!,
            "scope": ""
        ]
        request.perform(withSuccess: { (home) in
            print("success", home)
            
        }) { (err) in
            
            print("error", err)
        }
    }
    
    func setupContainerView() {
        scrolltoView.contentSize = view.bounds.size
        scrolltoView.addSubview(containerViews)
    
        scrolltoView.addSubview(logoImageView)
        scrolltoView.addSubview(emailTextField)
        scrolltoView.addSubview(passwordTextField)
        scrolltoView.addSubview(loginButton)
        
        view.addSubview(scrolltoView)
        
        scrolltoView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(20, 20, 20, 20))
        }
        
        containerViews.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(20, 20, 20, 20))
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrolltoView)
            make.centerX.equalTo(containerViews.snp.centerX)
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView).offset(150)
            make.left.equalTo(containerViews)
            make.right.equalTo(containerViews)
            make.centerX.equalTo(containerViews.snp.centerX)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField).offset(60)
            make.width.equalTo(emailTextField)
            make.centerX.equalTo(containerViews.snp.centerX)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField).offset(70)
            make.width.equalTo(emailTextField)
            make.centerX.equalTo(containerViews.snp.centerX)
            make.height.equalTo(50)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        navigationItem.title = "Login Page"
        
        setupContainerView()
    }
    
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
