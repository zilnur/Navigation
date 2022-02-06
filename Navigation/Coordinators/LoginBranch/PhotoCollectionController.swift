//
//  PhotoCollectionController.swift
//  Navigation
//
//  Created by Ильнур Закиров on 22.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionCoordinator {
    
    let navi: UINavigationController
    
    init(navi: UINavigationController) {
        self.navi = navi
    }
    
    func openSelf() {
        let photo = PhotosViewController()
        photo.coordinator = self
        navi.pushViewController(photo, animated: true)
    }
}
