import Foundation
import UIKit

final class MenuRouter:PresenterToRouterMenuProtocol {
    static func createModule() -> UIViewController {
        MenuViewController()
    }
}
