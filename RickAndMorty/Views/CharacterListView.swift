//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Esra Alın on 6.04.2023.
//

import UIKit

protocol CharacterListViewDelegate: AnyObject {
    func CharacterListView(
        _ characterListView: CharacterListView,
        didSelectCharacter character: Character
    )
}

/// View that handles showing list of characters, loader, etc.
final class CharacterListView: UIView {

    public weak var delegate: CharacterListViewDelegate?

    private let viewModel = CharacterListViewModel()

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    private let locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LocationCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        collectionView.register(FooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationCollectionView)
        addSubview(collectionView)
        addSubview(spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            locationCollectionView.topAnchor.constraint(equalTo: topAnchor),
            locationCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            locationCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            locationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension CharacterListView: CharacterListViewModelDelegate {
    func didSelectCharacter(_ character: Character) {
        delegate?.CharacterListView(self, didSelectCharacter: character)
    }

    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() 
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }

    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {

        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}

