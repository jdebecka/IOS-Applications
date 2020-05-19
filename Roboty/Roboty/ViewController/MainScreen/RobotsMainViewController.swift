//
//  ViewController.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
private let reuseIdentifier = "characterCell"
class RobotsMainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var robotMovieResource: Characters = []
    
    override func loadView() {
        super.loadView()
        getAllResources()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension RobotsMainViewController {
    func getAllResources() {
        RobotsMovieRepository.getMovieResources { (robots) in
            self.robotMovieResource = robots
            print(robots)
            self.collectionView.reloadData()
        }
    }
}
