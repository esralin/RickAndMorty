//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Esra Alın on 7.04.2023.
//

import UIKit


/// Single cell for each character
final class CharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
        addConstraints()
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
  
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            genderLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),

            genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            genderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),

            genderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        genderLabel.text = nil
    }

    public func configure(with viewModel: CharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        genderLabel.text = viewModel.characterGenderText
        checkGender(viewModel.getCharacterGender)
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    private func checkGender(_ gender: CharacterGender){
        if(gender == CharacterGender.female){
            nameLabel.textColor = UIColor.systemPink
        }
        else if(gender == CharacterGender.male){
            nameLabel.textColor = UIColor.systemBlue
            
        }
        else if(gender == CharacterGender.unknown || gender == CharacterGender.genderless){
            nameLabel.textColor = UIColor.label
        }
    }
}
