
import UIKit
import RealmSwift

class LoginInViewController: UIViewController {

    let scroll = UIScrollView()
    let logo = UIImageView(image:UIImage(named: "logo"))
    var login : UITextField = {
        let log1n = UITextField()
        log1n.layer.borderWidth = 0.5
        log1n.layer.borderColor = UIColor.lightGray.cgColor
        log1n.layer.cornerRadius = 10
        log1n.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        log1n.translatesAutoresizingMaskIntoConstraints = false
        log1n.textColor = .black
        log1n.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        log1n.autocapitalizationType = .none
        log1n.backgroundColor = .systemGray6
        log1n.clipsToBounds = true
        log1n.placeholder = "Email or Phone"
        return log1n
    }()
    var pass : UITextField = {
        let passTF = UITextField()
        passTF.layer.borderWidth = 0.5
        passTF.layer.borderColor = UIColor.lightGray.cgColor
        passTF.layer.cornerRadius = 10
        passTF.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passTF.translatesAutoresizingMaskIntoConstraints = false
        passTF.textColor = .black
        passTF.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passTF.autocapitalizationType = .none
        passTF.backgroundColor = .systemGray6
        passTF.clipsToBounds = true
        passTF.isSecureTextEntry = true
        passTF.placeholder = "Password"
        return passTF
    }()
    var loginButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Color")
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.alpha = 1
        if button.isSelected == true {
            button.alpha = 0.8
        } else if button.isEnabled == false {
            button.alpha = 0.8
        } else if button.isHighlighted == true {
            button.alpha = 0.8
        }
        button.addTarget(self, action: #selector(toProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(scroll)
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(login)
        scroll.addSubview(pass)
        scroll.addSubview(loginButton)
        
        setupView()
        
        func setupView() {
            let constrains = [
                scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                logo.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 120),
                logo.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
                logo.heightAnchor.constraint(equalToConstant: 100),
                logo.widthAnchor.constraint(equalToConstant: 100),
                
                login.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
                login.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
                login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                login.heightAnchor.constraint(equalToConstant: 50),
                
                pass.topAnchor.constraint(equalTo: login.bottomAnchor),
                pass.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
                pass.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                pass.heightAnchor.constraint(equalToConstant: 50),
                
                loginButton.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
                loginButton.topAnchor.constraint(equalTo: pass.bottomAnchor, constant: 16),
                loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                loginButton.heightAnchor.constraint(equalToConstant: 50)
                
            ]
            NSLayoutConstraint.activate(constrains)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard UserDefaults.standard.bool(forKey: "isDBInstalled") else {

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow(notification:)),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide(notification:)),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
            return
        }
        let realm = try! Realm()
        let users = realm.objects(User.self)
        let user = users[0]
        print(user)
        self.login.text = user.login
        self.pass.text = user.pass
        let profileVC = ProfileViewController(user: user)
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func toProfile() {
        let realm = try! Realm()
        guard let login = login.text, let pass = pass.text else {
            return
        }
        let user = User(login: login, pass: pass)
        try! realm.write {realm.add(user)}
        UserDefaults.standard.set(true, forKey: "isDBInstalled")
        let profileVC = ProfileViewController(user: user)
        navigationController?.pushViewController(profileVC, animated: true)
    }

}
            
private extension LoginInViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scroll.contentInset.bottom = keyboardSize.height
            scroll.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scroll.contentInset.bottom = .zero
        scroll.verticalScrollIndicatorInsets = .zero
    }
}
