import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "dataCell"
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let dataImageView = UIImageView()
    let priceButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    var cellViewModel:DataCellViewModel? {
        didSet {
            self.updateUI()
        }
    }
    
    enum NameLabelConstantUI:CGFloat {
        case font = 23
        case topAnchor = 10
        case leftAnchor = 20
    }
    enum DescriptionLabelConstantUI:CGFloat {
        case font = 17
        case topAnchor = 10
        case rightAnchor = -10
    }
    enum DataImageViewConstantUI:CGFloat {
        case allAnchor = 5
    }
    enum PriceButtonConstantUI:CGFloat {
        case bottomAnchor = -20
        case cornerRadius = 8
        case font = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: DataCollectionViewCell.NameLabelConstantUI.font.rawValue)
        self.addSubview(nameLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: DataCollectionViewCell.DescriptionLabelConstantUI.font.rawValue)
        self.addSubview(descriptionLabel)
        
        let emptyView:UIView = { // back view for image and activity indicator
           let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            return view
        }()
        self.addSubview(emptyView)
        
        dataImageView.translatesAutoresizingMaskIntoConstraints = false
        dataImageView.contentMode = .scaleAspectFit
        emptyView.addSubview(dataImageView)
        
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.layer.masksToBounds = true
        priceButton.layer.cornerRadius = PriceButtonConstantUI.cornerRadius.rawValue
        priceButton.setTitleColor(UIColor(named: GlobalConstant.purpleColor), for: .normal)
        priceButton.layer.borderColor = UIColor(named: GlobalConstant.purpleColor)?.cgColor
        priceButton.backgroundColor = .clear
        priceButton.layer.borderWidth = 1
        priceButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        priceButton.titleLabel?.font = .systemFont(ofSize: PriceButtonConstantUI.font.rawValue)
        self.addSubview(priceButton)
        
        
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: self.topAnchor),
            emptyView.leftAnchor.constraint(equalTo: self.leftAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emptyView.widthAnchor.constraint(equalToConstant: self.bounds.width / 3),
            dataImageView.topAnchor.constraint(equalTo: emptyView.topAnchor,constant: DataImageViewConstantUI.allAnchor.rawValue),
            dataImageView.leftAnchor.constraint(equalTo: emptyView.leftAnchor,constant: DataImageViewConstantUI.allAnchor.rawValue),
            dataImageView.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor,constant: DataImageViewConstantUI.allAnchor.rawValue),
            dataImageView.widthAnchor.constraint(equalTo: emptyView.widthAnchor),
            nameLabel.topAnchor.constraint(equalTo: emptyView.topAnchor,constant: NameLabelConstantUI.topAnchor.rawValue),
            nameLabel.leftAnchor.constraint(equalTo: emptyView.rightAnchor,constant: NameLabelConstantUI.leftAnchor.rawValue),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: DescriptionLabelConstantUI.topAnchor.rawValue),
            descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: DescriptionLabelConstantUI.rightAnchor.rawValue),
            priceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: PriceButtonConstantUI.bottomAnchor.rawValue),
            priceButton.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DataCollectionViewCell {
    private func updateUI() {
        nameLabel.text = cellViewModel?.title
        descriptionLabel.text = cellViewModel?.descriptText
        if let price = cellViewModel?.price {
            priceButton.setTitle("from \(price) p", for: .normal)
        }
        guard let urlString = cellViewModel?.image else {
            return
        }
        fetchImage(urlString: urlString, imageView: dataImageView, activityIndicator: activityIndicator)
    }
}
