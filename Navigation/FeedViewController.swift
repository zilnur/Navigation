import UIKit

final class FeedViewController: UIViewController {
    
    private let stack: UIStackView = {
        let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 10
         stack.backgroundColor = .blue
        return stack
    }()
    
    private let model = Model()
    
//    private let button1ToPost: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .gray
//        button.setTitle("Button1", for: .normal)
//        button.addTarget(self, action: #selector(toPostVC), for: .touchUpInside)
//        return button
//    }()
//    let button2ToPost: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .red
//        button.setTitle("Button2", for: .normal)
//        button.addTarget(self, action: #selector(toPostVC), for: .touchUpInside)
//        return button
//    }()

    private lazy var checkButton: CustomButton = {
        let button = CustomButton(title: "Check", titleColor: .white, backgroundColor: UIColor(named: "Color"))
        button.onTap = { [weak self] in
            if self?.model.check(word: self?.textField.text) == true {
                self?.label.text = "Правильно"
                self?.label.textColor = .green
            } else {
                self?.label.text = "Не правильно"
                self?.label.textColor = .red
            }
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textField: CustomTextField = {
        let textField = CustomTextField(font: UIFont.systemFont(ofSize: 13, weight: .regular), textColor: .black, placeholder: "Введите пароль")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        return textField
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        addSubviewsAndConstraints()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "post" else {
//            return
//        }
//        guard segue.destination is PostViewController else {
//            return
//        }
//    }
//
//    @objc func toPostVC() {
//        let sb = storyboard?.instantiateViewController(identifier: "postVC")
//        navigationController?.pushViewController(sb!, animated: true)
//    }
}

extension FeedViewController {
    func addSubviewsAndConstraints() {
        self.view.addSubview(stack)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(checkButton)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        [
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
        stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
        
        label.heightAnchor.constraint(equalToConstant: 40),
        label.widthAnchor.constraint(equalToConstant: 200),
        
        textField.heightAnchor.constraint(equalToConstant: 30),
        textField.widthAnchor.constraint(equalToConstant: 200),
        
        checkButton.heightAnchor.constraint(equalToConstant: 30),
        checkButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        .forEach {
                $0.isActive = true
            }
    }
}


