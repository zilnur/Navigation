import Foundation
import UIKit

protocol FactoryProtocol {
    func makeFeedModule() -> (presenter: FeedPresenter, controller: FeedViewController)
    func makeMainController() -> (UITabBarController, UINavigationController, UINavigationController)
    func makeLoginVC() -> LoginInViewController
    func makePostVC() -> PostViewController
}

final class Factory: FactoryProtocol {
    
    func makeMainController() -> (UITabBarController, UINavigationController, UINavigationController) {
        let tabBC = UITabBarController()
        tabBC.tabBar.backgroundColor = .white
        
        let navi1 = UINavigationController()
        let navi2 = UINavigationController()
        tabBC.viewControllers = [navi1, navi2]
        return (tabBC,navi1,navi2)
    }
    
    func makeFeedModule() -> (presenter: FeedPresenter, controller: FeedViewController){
        let presenter = FeedPresenter()
        let FeedVC = FeedViewController(output: presenter)
        return (presenter, FeedVC)
    }
        
    func makeLoginVC() -> LoginInViewController {
        let loginVC = LoginInViewController()
        return loginVC
    }
    
    func makePostVC() -> PostViewController {
        let postVC = PostViewController()
        return postVC
    }
    
}
