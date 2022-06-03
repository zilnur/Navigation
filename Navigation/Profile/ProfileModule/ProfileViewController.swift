
import UIKit

class ProfileViewController: UIViewController {
    
    let user: User
    
    let profileTable = UITableView(frame: .zero, style: .grouped)
    private var postItem: [Post] = [] {
        didSet {
            profileTable.reloadData()
        }
    }
    let profileHW = ProfileHederView()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.profileTable.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        self.profileTable.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        self.profileTable.dataSource = self
        self.profileTable.delegate = self
        
        profileHW.avatar.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        self.profileHW.avatar.addGestureRecognizer(gesture)
        let recognize = UITapGestureRecognizer(target: self, action: #selector(tapCloseButton))
        self.profileHW.closeButton.addGestureRecognizer(recognize)
        
        self.profileTable.tableFooterView = UIView()
        
        self.postItem = Posts.posts
        
        self.profileHW.avatarView.frame = CGRect(x: profileTable.frame.minX, y: profileTable.frame.minY, width: view.frame.width, height: view.frame.height)
        
        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(profileTable)
        self.profileTable.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            profileTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTable.topAnchor.constraint(equalTo: view.topAnchor),
            profileTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tapAvatar() {
        animation()
    }
    
    func animation() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.profileHW.avatar.frame = CGRect(x: 0, y: self.view.frame.midY - (self.view.frame.width / 2), width: self.view.frame.width, height: self.view.frame.width)
                self.profileHW.avatar.layer.cornerRadius = 0
                self.profileHW.closeButton.frame = CGRect(x: self.profileHW.avatarView.frame.maxX - 60, y: self.view.bounds.minY + 30, width: 30, height: 30)
                self.profileHW.avatarView.alpha = 0.75
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                self.profileHW.closeButton.alpha = 1
            }
        }, completion: nil)
        profileTable.allowsSelection = false
        profileTable.isScrollEnabled = false
    }
    
    @objc func tapCloseButton() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.profileHW.closeButton.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4) {
                self.profileHW.closeButton.frame = CGRect(x: self.profileHW.avatarView.frame.minX + 30, y: self.profileHW.avatarView.frame.minY + 30, width: 30, height: 30)
                
                self.profileHW.avatar.frame = CGRect(x: self.profileHW.frame.minX + 12, y: self.profileHW.frame.minY + 12, width: 100, height: 100)
                self.profileHW.avatar.layer.cornerRadius = 50
                self.profileHW.avatarView.alpha = 0
            }
        }
        profileTable.allowsSelection = true
        profileTable.isScrollEnabled = true
    }
}

extension ProfileViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.postItem.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = profileTable.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cell
        default : let cell = profileTable.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = self.postItem[indexPath.row - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosVC = PhotosViewController()
        switch  indexPath.row {
        case 0: navigationController?.pushViewController(photosVC, animated: true)
        default: break
        }
    }
}
extension ProfileViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHW
    }
}

