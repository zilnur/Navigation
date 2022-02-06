//
//  ProfileCoordinator.swift.swift
//  Navigation
//
//  Created by Ильнур Закиров on 22.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


class ProfileCoordinator {
    
    let navi: UINavigationController
    
    init(navi: UINavigationController) {
        self.navi = navi
    }
    
    func openProfile() {
        let profileVC = ProfileViewController()
        profileVC.coordinator = self
        navi.pushViewController(profileVC, animated: true)
    }
}

extension ProfileCoordinator: ProfileCoordinatorDelegate {
    func tophotoCollection() {
        let photoC = PhotoCollectionCoordinator(navi: navi)
        photoC.openSelf()
    }
}
