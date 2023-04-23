//
//  LocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Esra Alın on 10.04.2023.
//

import UIKit



final class LocationCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMLocationCollectionViewCell"
    


    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(locationLabel)
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
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        locationLabel.text = nil
    }

    public func configure(with viewModel: LocationCollectionViewCellViewModel) {
        locationLabel.text = viewModel.locationName
    
    }
    

}
