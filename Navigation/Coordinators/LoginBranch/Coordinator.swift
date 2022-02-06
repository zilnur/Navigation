import Foundation
import UIKit

//protocol CoordinatorProtocol {
//
//    var coordinatorChildren: [CoordinatorProtocol]? { get set }
//
//}
//
//class AppCoordinator: CoordinatorProtocol {
//
//    var coordinatorChildren: [CoordinatorProtocol]?
//
//    let tabBC = UITabBarController()
//
//    let navi1 = UINavigationController()
//    let navi2 = UINavigationController()
//
//    func start() {
//        self.tabBC.tabBar.tintColor = UIColor(named: "Color")
//        tabBC.tabBar.backgroundColor = .white
//
//        let loginCoordinator = LoginCoordinator(navi: navi1)
//        loginCoordinator.parentCoordinator = self
//        let loginVC = LoginInViewController()
//        loginVC.coordinator = loginCoordinator
////        let loginNVC = UINavigationController(rootViewController: loginVC)
//        loginVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 0)
//
//        let feedVC = FeedViewController()
////        let feedNVC = UINavigationController(rootViewController: feedVC)
//        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 1)
//
//        tabBC.viewControllers = [feedVC, loginVC]
//    }
//}

class Coordinator {
    
    let navi: UINavigationController
    let factory: FactoryProtocol
    
    init(navi: UINavigationController, factory: FactoryProtocol)  {
        self.navi = navi
        self.factory = factory
    }
    
    func openSelf() {
        let loginVC = factory.makeLoginVC()
        loginVC.coordinator = self
        navi.pushViewController(loginVC, animated: true)
    }
}

extension Coordinator: LoginInViewControllerDelegate {
    
    func toPVC() {
        let pCoordinator = ProfileCoordinator(navi: navi)
        pCoordinator.openProfile()
    }
    
}
