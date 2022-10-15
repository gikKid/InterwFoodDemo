import UIKit

func showErrorAlert(error:String) -> UIAlertController {
    let ac = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return ac
}
