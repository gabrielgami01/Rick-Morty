import UIKit

class EpisodeTableViewCell: UITableViewCell {
    static let identifier = "EpisodeTableViewCell"
    
    let nameLbl: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let airDateLbl: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let seasonLbl: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    let episodeLbl: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
        [nameLbl, airDateLbl, seasonLbl, episodeLbl]
            .forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            airDateLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),
            airDateLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 4),
            
            seasonLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),
            seasonLbl.topAnchor.constraint(equalTo: airDateLbl.bottomAnchor, constant: 16),
            
            episodeLbl.leadingAnchor.constraint(equalTo: seasonLbl.trailingAnchor, constant: 16),
            episodeLbl.topAnchor.constraint(equalTo: airDateLbl.bottomAnchor, constant: 16)
        ])
    }
    
    override func prepareForReuse() {
        self.nameLbl.text = nil
    }

    func configure(_ episode: Episode) {
        self.nameLbl.text = episode.name
        self.airDateLbl.text = episode.airDate
        self.seasonLbl.text = "Season \(episode.season)"
        self.episodeLbl.text = "Episode \(episode.episode)"
    }

}
