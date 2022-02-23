import Foundation
import FirebaseAuth
import UIKit

protocol LogInViewControllerDelegate {
    func didAuthSuccess()
    func didAuthFailed(reason: AuthErrorCode?)
 }

 struct LogInInspector {
     
     var loginInspectorDelegate: LogInViewControllerDelegate?
     
     func auth(login: String, pass: String) {
         Auth.auth().signIn(withEmail: login, password: pass) {  user, error in
             guard error == nil else {
                 let reason = AuthErrorCode(rawValue: error!._code)
                 self.loginInspectorDelegate?.didAuthFailed(reason: reason)
                 print("\(String(describing: error))")
                 return
             }
             self.loginInspectorDelegate?.didAuthSuccess()
             print("\(String(describing: user))")
         }
     }
     
     func createAcc(login: String?, pass: String?)  {
         guard let logIn = login, let password = pass else {return}
         FirebaseAuth.Auth.auth().createUser(withEmail: logIn, password: password) { result , error in
             
             guard error == nil else {
                 return
             }
             self.loginInspectorDelegate?.didAuthSuccess()
         }
     }
     
     func signOut() {
         do {
             try FirebaseAuth.Auth.auth().signOut()
             print("Выход")
         } catch {
             print("signOut error")
         }
     }
 }
