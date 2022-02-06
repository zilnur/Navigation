//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var coordinator: PostCoordinatorDelegate?
    var post = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = post
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toInfoVC))
    }
    
    @objc func toInfoVC() {
        coordinator?.toInfoVC()
    }
    
}
