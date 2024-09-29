import UIKit

final class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"
    
    let characterIV: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let speciesLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    override func prepareForReuse() {
        self.nameLbl.text = nil
        self.speciesLbl.text = nil
        self.characterIV.image = nil
    }
    
    private func setUpViews() {
        [characterIV, nameLbl, speciesLbl]
            .forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            characterIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterIV.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            characterIV.heightAnchor.constraint(equalToConstant: 80),
            characterIV.widthAnchor.constraint(equalToConstant: 80),
            
            nameLbl.leadingAnchor.constraint(equalTo: characterIV.trailingAnchor, constant: 24),
            nameLbl.topAnchor.constraint(equalTo: characterIV.topAnchor),
            
            speciesLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor),
            speciesLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 8)
            
        ])
    }
    
    func configure(_ character: Character) {
        self.nameLbl.text = character.name
        self.speciesLbl.text = character.species.capitalized
        
        if let imageUrl = character.image {
            Task {
                do {
                    let image = try await APIClient.shared.fetchCharacterImage(url: imageUrl)
                    await MainActor.run {
                        self.characterIV.image = image
                    }
                } catch {
                    await MainActor.run {
                        self.characterIV.image = UIImage(systemName: "person.crop.rectangle.fill")
                    }
                    print("Error al descargar la imagen: \(error)")
                }
            }
        }
    }
}
