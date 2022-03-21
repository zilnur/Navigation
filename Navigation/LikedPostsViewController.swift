//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by Ильнур Закиров on 19.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

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
        return DataBaseService.shared.setPost()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let deleteButton = UIBarButtonItem(title: "Удалить все", style: .plain, target: self, action: #selector(deleteAll))
        self.navigationItem.rightBarButtonItem = deleteButton
        tableView.dataSource = self
        tabBarController?.delegate = self
        setupViews()
        tableView.reloadData()
    }
    
    @objc func deleteAll() {
        DataBaseService.shared.deleteAll()
        self.tableView.reloadData()
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

extension LikedPostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        DataBaseService.shared.posts.count
        self.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell
//        cell?.post = DataBaseService.shared.posts[indexPath.item]
        cell?.post = self.posts[indexPath.item]
        return cell ?? UITableViewCell()
    }
    
}

extension LikedPostsViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.tableView.reloadData()
    }
}
