//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ильнур Закиров on 23.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeader = ProfileHederView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        self.view.addSubview(profileHeader)
        
    }
    
    override func viewWillLayoutSubviews() {
        profileHeader.frame = self.view.frame

    }
        
}
