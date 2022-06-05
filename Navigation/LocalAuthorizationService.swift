import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    let context = LAContext()
    
    var uerror: NSError?
    
    lazy var canUserBio = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: NSErrorPointer.none)
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Bool, Error>) -> Void) {
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Вход") { success, error in
            guard self.canUserBio else { return }
            if let error = error {
                authorizationFinished(.failure(error))
            } else {
                authorizationFinished(.success(success))
            }
        }
    }
}
