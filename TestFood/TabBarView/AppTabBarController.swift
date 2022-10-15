import Foundation
import UIKit

final class AppTabBarController:UITabBarController {
    
    private struct Constant {
        static let menuGrayImg = "GroupGray"
        static let menuPurpleImg = "GroupPurple"
        static let locationGrayImg = "LocationGray"
        static let locationPurpleImg = "LocationPurple"
        static let personGrayImg = "PersonGray"
        static let personPurpleImg = "PersonPurple"
        static let cartGrayImg = "ShoppingCartGray"
        static let cartPurpleImg = "ShoppingCartPurple"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = UIColor(named: GlobalConstant.purpleColor)
        
        let menuVC = MenuViewController()
        let menuTabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: AppTabBarController.Constant.menuGrayImg), selectedImage: UIImage(named: AppTabBarController.Constant.menuPurpleImg))
        
        let menuPresenter: (ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol) = MenuPresenter()
        menuVC.presenter = menuPresenter
        menuVC.presenter?.router = MenuRouter()
        menuVC.presenter?.view = menuVC
        menuVC.presenter?.interactor = MenuInteractor()
        menuVC.presenter?.interactor?.presenter = menuPresenter
        menuVC.tabBarItem = menuTabBarItem
        
        
        //FIXME: Hard code controllers !!!
        
        let locationTabBarItem = UITabBarItem(title: "Location", image: UIImage(named: AppTabBarController.Constant.locationGrayImg), selectedImage: UIImage(named: AppTabBarController.Constant.locationPurpleImg))
        let locationVC = UIViewController()
        locationVC.tabBarItem = locationTabBarItem
        
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: AppTabBarController.Constant.personGrayImg), selectedImage: UIImage(named: AppTabBarController.Constant.personPurpleImg))
        let profileVC = UIViewController()
        profileVC.tabBarItem = profileTabBarItem
        
        let cartTabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: AppTabBarController.Constant.cartGrayImg), selectedImage: UIImage(named: AppTabBarController.Constant.cartPurpleImg))
        let cartVC = UIViewController()
        cartVC.tabBarItem = cartTabBarItem
        
        self.viewControllers = [menuVC,locationVC,profileVC,cartVC]
        self.selectedIndex = 0
        
        
    }
    
    
}
