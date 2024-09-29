import UIKit

final class AlertCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        navigationController?.present(alert, animated: true)
    }
}
