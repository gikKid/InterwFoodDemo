import Foundation
import UIKit

final class MenuPresenter: ViewToPresenterMenuProtocol {

    var view: PresenterToViewMenuProtocol?
    var router: PresenterToRouterMenuProtocol?
    var interactor: PresenterToInteractorMenuProtocol?
    var pizza = [Pizza]()
    //FIXME: Mock data for categories
    var categoryMockData = ["Pizza","Combo","Dessertes","Drinks","Snacks"]
    var headerMockData:[String] = [GlobalConstant.dataImageDiscountURL,GlobalConstant.dataImageDiscountURL,GlobalConstant.dataImageDiscountURL]
    var categoryCellViewModels = [CategoryCellViewModel]()
    var dataCellViewModels = [DataCellViewModel]() {
        didSet {
            view?.onFetchDataSuccessful()
        }
    }
    
    init() {
        //FIXME: Hard code to get category data
        self.createCategoryModel()
    }
    
    public func numberOfSections() -> Int {
        2
    }
    
    public func numberOfRowsInCategorySection() -> Int {
        self.categoryMockData.count
    }
    
    public func setCategoryCell(collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> CategoryCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identefier, for: indexPath) as? CategoryCollectionViewCell else {
            return CategoryCollectionViewCell()
        }
        let cellViewModel = self.getCategoryCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    public func didSelectCategoryItemAt(collectionView: UICollectionView, indexPath: IndexPath) {
        
    }
    
    func numberOfRowsInDataSection() -> Int {
        self.pizza.count
    }
    
    public func setDataCell(collectionView: UICollectionView, forRowAt indexPath: IndexPath) -> DataCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataCollectionViewCell.identefier, for: indexPath) as? DataCollectionViewCell else {
            return DataCollectionViewCell()
        }
        let cellViewModel = self.getPizzaCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    
    
    public func didSelectDataItemAt(collectionView: UICollectionView, indexPath: IndexPath) {
        
    }
    
    public func viewDidLoad(headerView:MenuHeader,collectionView:UICollectionView) {
        interactor?.fetchData()
        headerView.mockData = headerMockData // to pass mock data
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .init())
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView, headerView: MenuHeader, headerViewTopConstraint:NSLayoutConstraint?,view: UIView) {
        let y = scrollView.contentOffset.y
        
        let swippingDown = y <= 0
        let shouldSnap = y > 30
        let collectionHeight = headerView.collectionView.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            headerView.collectionView.alpha = swippingDown ? 1.0 : 0.0
        })
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            headerViewTopConstraint?.constant = shouldSnap ? -collectionHeight : 0
            view.layoutIfNeeded()
        })
    }
    
    private func createCategoryModel() {
        
        var cellViewModelArray = [CategoryCellViewModel]()
        
        for category in categoryMockData {
            cellViewModelArray.append(CategoryCellViewModel(title: category))
        }
        self.categoryCellViewModels = cellViewModelArray
    }
    
    private func getCategoryCellViewModel(at indexPath:IndexPath) -> CategoryCellViewModel {
        return categoryCellViewModels[indexPath.row]
    }
    
    private func createDataCellViewModels(pizza:[Pizza]) {
        var cellViewModelArray = [DataCellViewModel]()
        
        for element in pizza {
            //FIXME: Hard code price and image url link
            cellViewModelArray.append(DataCellViewModel(title: element.name, descriptText: element.ingredients, price: "350", image: GlobalConstant.dataImageURL))
        }
        self.dataCellViewModels = cellViewModelArray
    }
    
    private func getPizzaCellViewModel(at indexPath:IndexPath) -> DataCellViewModel {
        return dataCellViewModels[indexPath.row]
    }

    
    
}

extension MenuPresenter: InteractorToPresenterMenuProtocol {
   public  func fetchDataSuccessful(pizza: [Pizza]) {
        self.pizza = pizza
        self.createDataCellViewModels(pizza: pizza)
        self.view?.onFetchDataSuccessful()
    }
    
    public func fetchDataFailure(error: String) {
        self.view?.onFetchDataFailure(error: error)
    }
    
    
}
