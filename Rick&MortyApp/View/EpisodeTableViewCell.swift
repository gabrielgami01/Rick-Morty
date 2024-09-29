import UIKit

class EpisodeTableViewCell: UITableViewCell {
    static let identifier = "EpisodeTableViewCell"
    
    let nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let episodeLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        [nameLbl, episodeLbl]
            .forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            episodeLbl.leadingAnchor.constraint(equalTo: nameLbl.trailingAnchor, constant: 16),
            episodeLbl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        ])
    }
    
    override func prepareForReuse() {
        self.nameLbl.text = nil
    }

    func configure(_ episode: Episode) {
        self.nameLbl.text = episode.name
        self.episodeLbl.text = "\(episode.season)"
    }

}
