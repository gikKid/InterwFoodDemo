import UIKit

final class MenuViewController: UIViewController {
    
    var presenter: (ViewToPresenterMenuProtocol & InteractorToPresenterMenuProtocol)?
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    enum LocationTitleConstantUI:CGFloat {
        case topAnchor = 15
        case leftAnchor = 20
        case size = 18
    }
    
    enum locationButtonConstantUI:CGFloat {
        case leftAnchor = 10
    }
    
    private struct Constant {
        static let locationImage = "chevron.down"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Setup view
    private func setupView() {
        self.view.backgroundColor = .white
        
        let locationTitle:UILabel = {
           let label = UILabel()
            //FIXME: Hard code text location !!!
            label.text = "Moscow"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            label.font = .systemFont(ofSize: LocationTitleConstantUI.size.rawValue)
            return label
        }()
        self.view.addSubview(locationTitle)
        
        let locationButton:UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: MenuViewController.Constant.locationImage), for: .normal)
            button.tintColor = .black
            return button
        }()
        self.view.addSubview(locationButton)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = .clear
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identefier)
        self.collectionView.register(DataCollectionViewCell.self, forCellWithReuseIdentifier: DataCollectionViewCell.identefier)
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        self.view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: LocationTitleConstantUI.topAnchor.rawValue),
            locationTitle.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: LocationTitleConstantUI.leftAnchor.rawValue),
            locationButton.centerYAnchor.constraint(equalTo: locationTitle.centerYAnchor),
            locationButton.leftAnchor.constraint(equalTo: locationTitle.rightAnchor, constant: MenuViewController.locationButtonConstantUI.leftAnchor.rawValue),
            collectionView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor,constant: 10),
            collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    //MARK: - Setup compositional layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout{ (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self.categoriesLayoutSection()
            default:
                return self.dataLayoutSection()
            }
        }
    }
    
    private func categoriesLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26), heightDimension: .fractionalHeight(0.35))
         
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
         
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(UIScreen.main.bounds.width), heightDimension: .fractionalHeight(0.1))
         
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
         let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
         section.orthogonalScrollingBehavior = .continuous
         return section
    }
    
    private func dataLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: item, count: 1)
        group.interItemSpacing = .fixed(CGFloat(10))
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
         
         return section
    }
    
}


//MARK: - Collection view methods
extension MenuViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.presenter?.numberOfRowsInCategorySection() ?? 0
        default:
            return self.presenter?.numberOfRowsInDataSection() ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return self.presenter?.setCategoryCell(collectionView: collectionView, forRowAt: indexPath) ?? UICollectionViewCell()
        default:
            return self.presenter?.setDataCell(collectionView: collectionView, forRowAt: indexPath) ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.presenter?.didSelectCategoryItemAt(collectionView: collectionView, indexPath: indexPath)
        default:
            self.presenter?.didSelectDataItemAt(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.numberOfSections() ?? 0
    }


}


//MARK: - PresenterToViewProtocol
extension MenuViewController: PresenterToViewMenuProtocol {
    func onFetchDataSuccessful() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onFetchDataFailure(error: String) {
        present(showErrorAlert(error: error),animated: true)
    }
    
    
}
