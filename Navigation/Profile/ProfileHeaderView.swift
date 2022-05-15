
import UIKit

class ProfileHederView: UIView {
    
    let avatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "forAvatar"))
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.createColor(lightMode: .black, darkMode: .white).cgColor
        return image
    }()
    
    let avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.createColor(lightMode: .blue, darkMode: .orange).cgColor
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Show status", for: .normal)
        button.addTarget(self, action: #selector(setStatus), for: .touchUpInside)
        return button
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Philip J. Fry"
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shut up and take my money"
        label.textColor = UIColor.createColor(lightMode: .systemGray, darkMode: .white)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .gray)
        textField.addTarget(self, action: #selector(newStatus(_ :)), for: .editingChanged)
        textField.layer.borderColor = UIColor.createColor(lightMode: .white, darkMode: .gray).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    var statusText = ""
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubviewsAndConstraints()
     }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @ objc func setStatus() {
        status.text = statusText
        statusTextField.text = nil
    }
    
    @ objc func newStatus(_ : UITextField) {
        statusText = statusTextField.text ?? ""
    }

}

extension ProfileHederView {
    func addSubviewsAndConstraints() {
        
        self.addSubview(button)
        self.addSubview(name)
        self.addSubview(status)
        self.addSubview(statusTextField)
        self.addSubview(avatarView)
        self.addSubview(avatar)
        self.avatarView.addSubview(closeButton)
        
        avatarView.frame = CGRect(x: self.frame.minX + 12, y: self.frame.minY + 12, width: 100, height: 100)
        avatar.frame = CGRect(x: self.frame.minX + 12, y: self.frame.minY + 12, width: 100, height: 100)
        closeButton.frame = CGRect(x: self.frame.maxX - 60, y: self.frame.minY + 30, width: 30, height: 30)
        closeButton.alpha = 0
        
        let constraints = [name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 132),
                           name.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
                           
                           button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                           button.topAnchor.constraint(equalTo: self.topAnchor, constant: 156),
                           button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                           button.heightAnchor.constraint(equalToConstant: 50),
                           button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -48),
                           
                           statusTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
                           statusTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 132),
                           statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                           statusTextField.heightAnchor.constraint(equalToConstant: 40),
                           
                           status.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 132),
                           status.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
