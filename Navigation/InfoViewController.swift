//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    let nc = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        addSubviews()
        nc.startURLSession(label: self.label1)
        nc.decode(label: self.label2)
    }
}

extension InfoViewController {
    func addSubviews() {
        [self.label1, self.label2].forEach(self.view.addSubview(_:))
        
        let constraints = [
            self.label1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.label1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.label1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            self.label1.heightAnchor.constraint(equalToConstant: 75),
            
            self.label2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 15),
            self.label2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            self.label2.heightAnchor.constraint(equalToConstant: 75)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
