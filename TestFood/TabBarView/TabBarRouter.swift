import Foundation
import UIKit

final class TabBarRouter:PresenterToRouterTabBarProtocol {
    static func createModule() -> UITabBarController {
         AppTabBarController()
    }
}
