
import UIKit

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
    let choosePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Choose a password", for: .normal)
        button.backgroundColor = UIColor(named: "Color")
        button.layer.cornerRadius = 10
        button.alpha = 1
        if button.isSelected == true {
            button.alpha = 0.8
        } else if button.isEnabled == false {
            button.alpha = 0.8
        } else if button.isHighlighted == true {
            button.alpha = 0.8
        }
        button.addTarget(self, action: #selector(tapOnChooseButton), for: .touchUpInside)
        return button
    }()
    
    let indicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        ind.translatesAutoresizingMaskIntoConstraints = false
        return ind
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scroll)
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(login)
        scroll.addSubview(pass)
        scroll.addSubview(loginButton)
        scroll.addSubview(choosePasswordButton)
        scroll.addSubview(indicator)
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
                loginButton.heightAnchor.constraint(equalToConstant: 50),
                
                choosePasswordButton.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
                choosePasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
                choosePasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                choosePasswordButton.heightAnchor.constraint(equalToConstant: 50),
                
                indicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
                indicator.topAnchor.constraint(equalTo: login.bottomAnchor),
                indicator.heightAnchor.constraint(equalToConstant: 50),
                indicator.widthAnchor.constraint(equalToConstant: 50)
                
            ]
            NSLayoutConstraint.activate(constrains)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func toProfile() {
        if login.text != "" && pass.text != "" {
            let profile = ProfileViewController()
            navigationController?.pushViewController(profile, animated: true)
        } else {
            login.placeholder = "Необходимо заполнить!"
            pass.placeholder = "Необходимо заполнить!"
        }
    }
    
    @objc func tapOnChooseButton() {
        self.indicator.startAnimating()
        let dispatch = DispatchQueue(label: "HW", qos: .userInitiated, attributes: .concurrent)
            dispatch.async {
                self.bruteForce(passwordToUnlock: "123")
        }
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

extension LoginInViewController {
        
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        // Will strangely ends at 0000 instead of ~~~
        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            // Your stuff here
    //            print(password)
            // Your stuff here
        }
        DispatchQueue.main.async {
            self.pass.placeholder = nil
            self.pass.text = password
            self.pass.isSecureTextEntry = false
            self.indicator.stopAnimating()
        }
        print(password)
    }
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

