//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Ильнур Закиров on 14.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var photoCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.backgroundColor = .white
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        
        photoCollection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        
        photoCollection.dataSource = self
        photoCollection.delegate = self
        
        return photoCollection
    }()
    
    private var photoSection:[UIImage] = [] {
        didSet {
            photoCollection.reloadData()
        }
    }
     
    var time = 3
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.cornerRadius = 25
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.layer.borderColor = UIColor(named: "Color")?.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        self.navigationController?.isNavigationBarHidden = false
        self.editTime()
}
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

extension PhotosViewController {
    func setupView() {
        self.view.addSubview(photoCollection)
        self.view.addSubview(timeLabel)
        let constrains = [
            photoCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
//            timeLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
//            timeLabel.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            timeLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            timeLabel.heightAnchor.constraint(equalToConstant: 50),
            timeLabel.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constrains)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.photoInCollection.image = photoSection[indexPath.item]
        return cell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = (collectionView.frame.width - 8*5)/3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension PhotosViewController {
    func editTime() {
        DispatchQueue.global(qos: .userInteractive).async {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.time -= 1
                DispatchQueue.main.async {
                    self.timeLabel.text = "\(self.time)"
                }
                if self.time == 0 {
                    let photo = Photos.photos.randomElement()
                    if let image = photo {
                        let index = Photos.photos.firstIndex(of: image)
                        DispatchQueue.main.async {
                            self.photoSection.append(image)
                            Photos.photos.remove(at: index!)
                        }
                    }
                    self.time = 3
                }
                if Photos.photos.count == 0 {
                    timer.invalidate()
                }
            }
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
    }
}

