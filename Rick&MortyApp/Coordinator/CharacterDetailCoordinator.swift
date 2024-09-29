import UIKit

final class CharacterDetailCoordinator: Coordinator {
    let character: Character
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?, character: Character) {
        self.navigationController = navigationController
        self.character = character
    }
    
    func start() {
        let characterDetailVC = CharacterDetailViewController(character: character)
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
