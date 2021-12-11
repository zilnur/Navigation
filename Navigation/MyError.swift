import Foundation

enum MyError: Error {
    case postsNotFound
    case photosNotFound
    
    func error() {
        switch self {
        case .postsNotFound:
            
        }
    }
}
