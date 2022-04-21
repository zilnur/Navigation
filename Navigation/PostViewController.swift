import UIKit

class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        let InfoButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toInfo))
        self.navigationItem.rightBarButtonItem = InfoButton
    }
    
    @objc func toInfo() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .formSheet
        infoVC.modalTransitionStyle = .coverVertical
        self.present(infoVC, animated: true, completion: nil)
    }
}
