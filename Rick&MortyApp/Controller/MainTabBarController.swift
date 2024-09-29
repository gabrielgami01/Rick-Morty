import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewControllers()
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func setUpViewControllers() {
        let charactersNavController = UINavigationController(rootViewController: CharactersTableViewController())
        let episodesNavController = UINavigationController(rootViewController: EpisodesTableViewController())
        
        charactersNavController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.crop.circle"), tag: 0)
        episodesNavController.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "list.number"), tag: 1)
        
        setViewControllers([charactersNavController,episodesNavController], animated: true)
    }

}

