import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    static let identefier = "HeaderCollectionCell"
    var dataImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var urlString = "" {
        didSet {
            fetchImage(urlString: urlString, imageView: dataImageView, activityIndicator: activityIndicator)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        
        dataImageView.translatesAutoresizingMaskIntoConstraints = false
        dataImageView.contentMode = .scaleAspectFill
        dataImageView.layer.cornerRadius = 15
        dataImageView.clipsToBounds = true
        self.addSubview(dataImageView)
        
    
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dataImageView.topAnchor.constraint(equalTo: self.topAnchor),
            dataImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            dataImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dataImageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
