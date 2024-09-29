import UIKit

final class CharacterDetailView: UIView {
    private let statusHeader: UILabel = UILabel.createHeaderLabel(text: "Status: ")
    private let speciesHeader: UILabel = UILabel.createHeaderLabel(text: "Species: ")
    private let genderHeader: UILabel = UILabel.createHeaderLabel(text: "Gender: ")
    private let originHeader: UILabel = UILabel.createHeaderLabel(text: "Origin: ")
    private let locationHeader: UILabel = UILabel.createHeaderLabel(text: "Location: ")
    
    private let characterIV: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    private let nameLbl = UILabel.createLabel(for: .title1)
    private let statusLbl = UILabel.createLabel(for: .body)
    private let speciesLbl = UILabel.createLabel(for: .body)
    private let genderLbl = UILabel.createLabel(for: .body)
    private let originLbl = UILabel.createLabel(for: .body)
    private let locationLbl = UILabel.createLabel(for: .body)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createHStack(with header: UILabel, _ label: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [header, label])
        stackView.axis = .horizontal
        
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    private func setUpViews() {
        backgroundColor = .systemBackground

        let stackView = UIStackView(arrangedSubviews: [
            createHStack(with: speciesHeader, speciesLbl),
            createHStack(with: genderHeader, genderLbl),
            createHStack(with: originHeader, originLbl),
            createHStack(with: locationHeader, locationLbl),
            createHStack(with: statusHeader, statusLbl)
        ])

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(characterIV)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            characterIV.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterIV.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            characterIV.heightAnchor.constraint(equalToConstant: 250),
            characterIV.widthAnchor.constraint(equalToConstant: 250),

            stackView.topAnchor.constraint(equalTo: characterIV.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func configure(_ character: Character) {
        self.nameLbl.text = character.name.capitalized
        self.statusLbl.text = character.status.capitalized
        self.speciesLbl.text = character.species.capitalized
        self.genderLbl.text = character.gender.capitalized
        self.originLbl.text = character.origin.capitalized
        self.locationLbl.text = character.location.capitalized
        
        if let imageUrl = character.image {
            Task {
                do {
                    let image = try await APIClient.shared.fetchCharacterImage(url: imageUrl.appendingPathComponent("image"))
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
