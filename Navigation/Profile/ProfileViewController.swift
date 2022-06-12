
import UIKit
import UniformTypeIdentifiers

class ProfileViewController: UIViewController {
    
    let profileTable = UITableView(frame: .zero, style: .grouped)
    private var postItem: [Post] = [] {
        didSet {
            profileTable.reloadData()
        }
    }
    let profileHW = ProfileHederView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(profileTable)
        self.profileTable.translatesAutoresizingMaskIntoConstraints = false
        self.profileTable.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        self.profileTable.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        self.profileTable.dataSource = self
        self.profileTable.delegate = self
        self.profileTable.dragInteractionEnabled = true
        self.profileTable.dropDelegate = self
        self.profileTable.dragDelegate = self
        self.profileTable.reloadData()
        
        profileHW.avatar.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        self.profileHW.avatar.addGestureRecognizer(gesture)
        let recognize = UITapGestureRecognizer(target: self, action: #selector(tapCloseButton))
        self.profileHW.closeButton.addGestureRecognizer(recognize)
        
        self.profileTable.tableFooterView = UIView()
        
        self.postItem = Posts.posts
        
        let refresh = UIRefreshControl()
        self.profileTable.refreshControl = refresh
        
        self.profileHW.avatarView.frame = CGRect(x: profileTable.frame.minX, y: profileTable.frame.minY, width: view.frame.width, height: view.frame.height)
        setupView()
    }
    
    func setupView() {
        
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
        return self.postItem.count + 1
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

@available(iOS 14.0, *)
extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let description = self.postItem[indexPath.item - 1].description ?? ""
        let descriptionData = description.data(using: .utf8)
        
        let image = self.postItem[indexPath.item - 1].image
        let imageData = image?.jpegData(compressionQuality: 1)
        
        let descriptionItemProvider = NSItemProvider(object: description as NSItemProviderWriting)
        let descriptionDragItem = UIDragItem(itemProvider: descriptionItemProvider)
        descriptionDragItem.localObject = descriptionData
        
        let imageItemProvider = NSItemProvider(object: image!)
        let imageDragItem = UIDragItem(itemProvider: imageItemProvider)
        imageDragItem.localObject = imageData
        
        return [imageDragItem, descriptionDragItem]
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [UTType.text.identifier, UTType.image.identifier])
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        
        guard session.items.count == 2 else { return dropProposal }
        
        if tableView.hasActiveDrag {
            dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            dropProposal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        
        return dropProposal
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        var post = Post(autor: "Drag&Drop", description: nil, image: nil, likes: 0, views: 0)
        coordinator.session.loadObjects(ofClass: NSString.self) { strings in
            let ustrings = strings as! [String]
            for ustring in ustrings {
                if !ustring.isContiguousUTF8 {
                post.description = ustring
                }
            }

        }
        coordinator.session.loadObjects(ofClass: UIImage.self) { images in
            let uImages = images as! [UIImage]
            for uImage in uImages {
                post.image = uImage
            }
            self.postItem.insert(post, at: destinationIndexPath.item)
        }
    }
}
