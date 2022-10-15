import Foundation
import UIKit

//MARK: - View Input (View -> Presenter)
protocol ViewToPresenterMenuProtocol {
    var view:PresenterToViewMenuProtocol? {get set}
    var router: PresenterToRouterMenuProtocol? {get set}
    var interactor: PresenterToInteractorMenuProtocol? {get set}
    
    func numberOfSections() -> Int
    func numberOfRowsInCategorySection() -> Int
    func setCategoryCell(collectionView:UICollectionView, forRowAt indexPath:IndexPath) -> CategoryCollectionViewCell
    func didSelectCategoryItemAt(collectionView:UICollectionView, indexPath:IndexPath)
    func numberOfRowsInDataSection() -> Int
    func setDataCell(collectionView:UICollectionView, forRowAt indexPath:IndexPath) -> DataCollectionViewCell
    func didSelectDataItemAt(collectionView:UICollectionView, indexPath:IndexPath)
    func viewDidLoad(headerView:MenuHeader)
    
}

//MARK: - View Output (Presenter -> View)
protocol PresenterToViewMenuProtocol {
    func onFetchDataSuccessful()
    func onFetchDataFailure(error:String)
    
}

//MARK: -  Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMenuProtocol {
    var presenter: InteractorToPresenterMenuProtocol? {get set}
    func fetchData()
}

//MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMenuProtocol {
    func fetchDataSuccessful(pizza:[Pizza])
    func fetchDataFailure(error:String)
    
}

//MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterMenuProtocol {
    static func createModule() -> UIViewController
}

