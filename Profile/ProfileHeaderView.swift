//
//  ProfileView.swift
//  Navigation
//
//  Created by Ильнур Закиров on 23.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileHederView: UIView {
    
    let avatar = UIImageView(image: UIImage(named: "forAvatar"))
    let button = UIButton()
    let name = UILabel()
    let status = UILabel()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.addSubview(avatar)
        self.addSubview(button)
        self.addSubview(name)
        self.addSubview(status)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        avatar.clipsToBounds = true
        avatar.frame = CGRect(x: 16, y: safeAreaInsets.top + 16, width: 100, height: 100)
        avatar.layer.backgroundColor = UIColor.systemIndigo.cgColor
        avatar.layer.cornerRadius = avatar.frame.size.height / 2
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        
        button.frame = CGRect(x: 16, y: Int(avatar.frame.maxY) + 16, width: Int(self.bounds.width) - 32, height: 50)
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Show status", for: .normal)
        button.addTarget(self, action: #selector(showStatus), for: .touchUpInside)
        
        name.frame = CGRect(x: Int(avatar.frame.maxX) + 16, y: Int(safeAreaInsets.top) + 27, width: 200, height: 30)
        name.text = "Philip J. Fry"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        status.frame = CGRect(x: Int(avatar.frame.maxX) + 16, y: Int(button.frame.minY) - 64, width: 200, height: 30)
        status.text = "Shut up and take my money"
        status.textColor = .gray
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
    }
    
    @ objc func showStatus() {
        print(status.text ?? "No status")
    }
    
}
