import UIKit

final class CharacterTableViewController: UITableViewController {
    var characters: [Character] = []
    var page = 1
    
    private var characterDetailCoordinator: CharacterDetailCoordinator?
    private var alertCoordinator: AlertCoordinator?

    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CharacterListCellView.self, forCellReuseIdentifier: CharacterListCellView.identifier)
        
        navigationItem.title = "Rick & Morty"
        
        configureSearchController()

        Task { await getCharacters(page: page) }
    }
    
    private func getCharacters(page: Int) async {
        do {
            let characters = try await APIClient.shared.fetchCharacters(page: page)
            await MainActor.run {
                self.characters += characters
                self.tableView.reloadData()
            }
        } catch {
            alertCoordinator = AlertCoordinator(navigationController: self.navigationController)
            alertCoordinator?.showErrorAlert(message: error.localizedDescription)
        }
    }
    
    private func searchCharacter(name: String) async {
        do {
            let searchResults = try await APIClient.shared.searchCharacter(name: name)
            await MainActor.run {
                self.characters = searchResults
                self.tableView.reloadData()
            }
        } catch {
            alertCoordinator = AlertCoordinator(navigationController: self.navigationController)
            alertCoordinator?.showErrorAlert(message: error.localizedDescription)
        }
    }
    
    private func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
                
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCellView.identifier, for: indexPath) as? CharacterListCellView else {
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.configure(character)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        characterDetailCoordinator = CharacterDetailCoordinator(navigationController: self.navigationController, character: character)
        characterDetailCoordinator?.start()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchController.searchBar.text?.isEmpty == true {
            let character = characters[indexPath.row]
            if characters.last?.id == character.id {
                page += 1
                Task { await getCharacters(page: page) }
            }
        }
    }
}

extension CharacterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            characters.removeAll()
            page = 1
            Task { await getCharacters(page: page) }
        } else {
            Task { await searchCharacter(name: searchText) }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        characters.removeAll()
        page = 1
        Task { await getCharacters(page: page) }
    }
    
}
