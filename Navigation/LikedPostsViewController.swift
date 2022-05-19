import UIKit

class LikedPostsViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return table
    }()
    
    var posts: [Post] {
        get {
            return DataBaseService.shared.setPosts()
        }
    }
    
    lazy var filteredPosts: [Post] = []
    
    var isFiltered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tabBarController?.delegate = self
        setupViews()
        naviConfig()
        tableView.reloadData()
    }
    
}

extension LikedPostsViewController {
    func setupViews() {
        self.view.addSubview(tableView)
        
        [self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered == false {
            return self.posts.count
        } else {
            return self.filteredPosts.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell
        if isFiltered == false {
        cell?.post = self.posts[indexPath.item]
        } else {
            cell?.post = self.filteredPosts[indexPath.item]
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in
            if !self.isFiltered {
                DataBaseService.shared.deletePost(indexPath.item)
                self.tableView.reloadData()
            } else {
                let post = self.filteredPosts[indexPath.item]
                if let index = self.posts.firstIndex(where: {$0.autor == post.autor}) {
                    DataBaseService.shared.deletePost(index)
                    self.filteredPosts.remove(at: indexPath.item)
                    self.tableView.reloadData()
                }
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension LikedPostsViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.tableView.reloadData()
    }
}

extension LikedPostsViewController {
    func naviConfig() {
        let deleteButton = UIBarButtonItem(title: "Показать все", style: .plain, target: self, action: #selector(deleteAll))
        self.navigationItem.rightBarButtonItem = deleteButton
        
        let sortButton = UIBarButtonItem(title: "Поиск", style: .plain, target: self, action: #selector(sortTapped))
        self.navigationItem.leftBarButtonItem = sortButton
    }
    
    @objc func deleteAll() {
        self.isFiltered = false
        self.tableView.reloadData()
    }
    
    @objc func sortTapped() {
        let alert = UIAlertController(title: "Поиск по автору", message: "Введите имя автора", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let alertOK = UIAlertAction(title: "Ок", style: .default) {_ in
            guard let request = alert.textFields?[0].text else {return}
            self.filteredPosts = self.posts.filter { (post: Post) -> Bool in
                return post.autor?.lowercased().contains(request.lowercased()) ?? false
            }
            self.isFiltered = true
            self.tableView.reloadData()
            print(self.filteredPosts.count)
        }
        let alertNo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        [alertNo,alertOK].forEach(alert.addAction(_:))
        present(alert, animated: true)
    }
}
