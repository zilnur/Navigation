import Foundation
import UIKit

class User {
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(fullname: String, avatar: UIImage, status: String) {
        self.fullName = fullname
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    func userService(name: String) -> User?
}

class CurrentUserService: UserService {
    let user = User(fullname: "1", avatar: UIImage(named: "forAvatar")!, status: "Shut up and take my money")
    
    func userService(name: String) -> User? {
        if user.fullName == name {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
    let user = User(fullname: "test", avatar: UIImage(systemName: "person")!, status: "Status")
    
    func userService(name: String) -> User? {
        if user.fullName == name {
            return user
        } else {
            return nil
        }
    }
}
