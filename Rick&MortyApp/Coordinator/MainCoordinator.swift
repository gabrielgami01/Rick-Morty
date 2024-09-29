import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let characterTableVC = CharacterTableViewController()
        navigationController?.pushViewController(characterTableVC, animated: true)
    }
}
