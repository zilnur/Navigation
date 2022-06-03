import Foundation

class LoginHelper {
    
    let users = Users()
    
    var presenter: LoginPresenter?
    
    func logIn(login: String?, pass: String?) {
        guard let uLogIn = login, let uPass = pass else {
            return
        }
        let myUser = User(name: uLogIn, pass: uPass)
        let bool = users.users.contains { user in
            if myUser.name == user.name && myUser.pass == user.pass {
                return true
            } else {
                return false
            }
        }
        presenter?.logInProfile(user: myUser, isAccess: bool)
    }
}
