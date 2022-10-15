import UIKit

func showErrorAlert(error:String) -> UIAlertController {
    let ac = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return ac
}

func fetchImage(urlString:String,imageView:UIImageView,activityIndicator:UIActivityIndicatorView) {
    guard let url = URL(string: urlString) else {
        imageView.image = UIImage(systemName: GlobalConstant.failedImage)
        return
    }
    let imageRequest = ImageRequest(url: url)
    
    DispatchQueue.global(qos: .userInitiated).async {
        imageRequest.execute(withCompletion: { image,error in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                imageView.image = image
            }
        })
    }
}
