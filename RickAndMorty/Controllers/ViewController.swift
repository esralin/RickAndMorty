//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Esra Alın on 5.04.2023.
//

import UIKit


class ViewController: UIViewController {
    
    private let characterListView = CharacterListView()
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
      
        setUpView()
    

   
    }
    
    private func setUpView(){
        view.addSubview(characterListView)
             NSLayoutConstraint.activate([
                 characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                 characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                 characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                 characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
             ])
    }



}

