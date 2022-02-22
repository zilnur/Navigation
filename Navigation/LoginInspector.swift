import Foundation
import FirebaseAuth
import UIKit

protocol LogInViewControllerDelegate {
    var onSignIN: () -> () { get set }
    var onCreate: () -> () { get set }
    
    func logInCheck(logIn: String?, pass: String?)
    func createAcc(login: String, pass: String)
    func signOut()
 }

 class LogInInspector: LogInViewControllerDelegate {
     
     var onSignIN = {}
     var onCreate = {}
     func logInCheck(logIn: String?, pass: String?) {
         guard let login = logIn, let pass = pass else {return}
         FirebaseAuth.Auth.auth().signIn(withEmail: login, password: pass) { [weak self] result , error in
             
             guard error == nil else {
                 self?.onCreate()
                 return
             }
             print("OK")
             self?.onSignIN()
         }
 }
     
     func createAcc(login: String, pass: String)  {
         FirebaseAuth.Auth.auth().createUser(withEmail: login, password: pass) { [weak self] result , error in
             
             guard error == nil else {
                 print("\(String(describing: error))")
                 return
             }
             print("OK")
             self?.onSignIN()
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
