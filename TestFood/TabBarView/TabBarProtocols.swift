import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterTabBarProtocol {
    var view:PresenterToViewTabBarProtocol? {get set}
    var router: PresenterToRouterTabBarProtocol? {get set}
    var interactor: PresenterToInteractorTabBarProtocol? {get set}
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewTabBarProtocol {
    
}

//MARK: -  Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTabBarProtocol {
    var presenter: InteractorToPresenterTabBarProtocol? {get set}
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTabBarProtocol {
    
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterTabBarProtocol {
    static func createModule() -> UITabBarController
}
