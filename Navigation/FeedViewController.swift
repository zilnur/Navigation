
import UIKit

final class FeedViewController: UIViewController {
    
    
    let button1ToPost = UIButton()
    let button2ToPost = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        self.view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [self.button1ToPost, self.button2ToPost])

        self.view.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        [
        stack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
        stack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard segue.destination is PostViewController else {
            return
        }
    }
    
    @objc func toPostVC() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}

