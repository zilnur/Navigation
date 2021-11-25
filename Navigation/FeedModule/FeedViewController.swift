import UIKit

final class FeedViewController: UIViewController {
        
    var output: FeedModuleControllerOutput?
    let button1ToPost = UIButton()
    let button2ToPost = UIButton()
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tf.textColor = .black
        tf.addTarget(self, action: #selector(edit), for: .editingChanged)
        return tf
    }()
    
    
    
    private var tfText = ""
    
    init(output: FeedModuleControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        let stack = UIStackView(arrangedSubviews: [self.textField ,self.button1ToPost, self.button2ToPost])

        self.view.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        [
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        
        textField.heightAnchor.constraint(equalToConstant: 30),
        textField.widthAnchor.constraint(equalToConstant: 200),
        
        button1ToPost.heightAnchor.constraint(equalToConstant: 30),
        button1ToPost.widthAnchor.constraint(equalToConstant: 200),
        
        button2ToPost.heightAnchor.constraint(equalToConstant: 30),
        button2ToPost.widthAnchor.constraint(equalToConstant: 200)
        ]
        .forEach {
                $0.isActive = true
            }
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .blue
        
        button1ToPost.backgroundColor = .gray
        button1ToPost.setTitle("Button1", for: .normal)
        button1ToPost.addTarget(self, action: #selector(toPostVC), for: .touchUpInside)
        
        button2ToPost.backgroundColor = .red
        button2ToPost.setTitle("Button2", for: .normal)
        button2ToPost.addTarget(self, action: #selector(toPostVC), for: .touchUpInside)
    }
    
    @objc func toPostVC() {
        output?.output(word: tfText)
    }
    
    @objc func edit() {
        tfText = textField.text!
    }
}


