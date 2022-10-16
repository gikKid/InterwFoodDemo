import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "categoryCell"
    let nameLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(named: Constant.backSelectedColor) : .clear
            self.nameLabel.textColor = isSelected ? UIColor(named: GlobalConstant.purpleColor) : UIColor(named: Constant.categoryColor)
            self.nameLabel.font = isSelected ? .boldSystemFont(ofSize: 17) : .systemFont(ofSize: 16)
        }
    }
    
    var cellViewModel:CategoryCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.title
        }
    }
    
    private struct Constant {
        static let backSelectedColor = "categoryBackSelected"
        static let categoryColor = "categoryCellColor"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: Constant.categoryColor)?.cgColor
        self.layer.cornerRadius = 12
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor(named: Constant.categoryColor)
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
