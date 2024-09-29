import UIKit

final class CharacterDetailViewController: UIViewController {
    var mainView: CharacterDetailView { self.view as! CharacterDetailView }
    var character: Character?
    
    private var alertCoordinator: AlertCoordinator?
    
    
    init(character: Character) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
        
        mainView.configure(character)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CharacterDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = character?.name
    }
}
