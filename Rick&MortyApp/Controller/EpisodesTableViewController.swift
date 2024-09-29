import UIKit

class EpisodesTableViewController: UITableViewController {
    var episodes: [Episode] = []
    var page = 1
    
    private var alertCoordinator: AlertCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        
        navigationItem.title = "Episodes"
        
        Task { await getCharacters(page: page) }
    }
    
    private func getCharacters(page: Int) async {
        do {
            let episodes = try await APIClient.shared.fetchEpisodes(page: page)
            await MainActor.run {
                self.episodes += episodes
                self.tableView.reloadData()
            }
        } catch {
            alertCoordinator = AlertCoordinator(navigationController: self.navigationController)
            alertCoordinator?.showErrorAlert(message: error.localizedDescription)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        let episode = episodes[indexPath.row]
        cell.configure(episode)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        if episodes.last?.id == episode.id {
            page += 1
            Task { await getCharacters(page: page) }
        }
    }
}
