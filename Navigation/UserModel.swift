import Foundation
import RealmSwift

class User: Object {
    @Persisted var login: String
    @Persisted var pass: String
    
    convenience init(login: String, pass: String) {
        self.init()
        self.login = login
        self.pass = pass
    }
}
