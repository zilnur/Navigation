import Foundation
import UIKit

protocol PostCoordinatorDelegate {
    func toInfoVC()
}

class PostCoordinator: PostCoordinatorDelegate {
    
    let navi: UINavigationController
    private let factory: FactoryProtocol
    
    init(navi: UINavigationController, factory: FactoryProtocol) {
        self.navi = navi
        self.factory = factory
    }
    
    func openSelf(post: String) {
        let postVC = PostViewController()
        postVC.post = post
        postVC.coordinator = self
        navi.pushViewController(postVC, animated: true)
    }
    
    func toInfoVC() {
        let infoVC = InfoViewController()
        navi.present(infoVC, animated: true, completion: nil)
    }
}
