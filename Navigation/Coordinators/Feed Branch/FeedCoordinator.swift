import Foundation
import UIKit


protocol FeedViewCoordinatorDelegate {
    func toPostVC(post: String)
}

class FeedCoordinator {

    private let factory: FactoryProtocol
    let navi: UINavigationController
    
    init(navi: UINavigationController, factory: FactoryProtocol) {
        self.navi = navi
        self.factory = factory
    }
 
    func makeSelf() {
        let feed = factory.makeFeedModule()
        feed.presenter.coordinator = self
        navi.pushViewController(feed.controller, animated: true)
    }
    
}

extension FeedCoordinator: FeedViewCoordinatorDelegate {
    
    func toPostVC(post: String) {
        let coordinator = PostCoordinator(navi: navi, factory: factory)
        coordinator.openSelf(post: post)
    }
    
}

