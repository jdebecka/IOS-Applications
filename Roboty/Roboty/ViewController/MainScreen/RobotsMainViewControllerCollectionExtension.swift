//
//  ViewControllerCollectionExtension.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

private let reuseIdentifier = "characterCell"

extension RobotsMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return robotMovieResource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        let character = robotMovieResource[indexPath.row]
        cell.characterLabel.text = character.characterName
        cell.polishCharacterLabel.text = character.polishCharacterName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CharacterDetail") as! CharacterDetailViewController
        let character = robotMovieResource[indexPath.row]
        characterVC.data = character
        navigationController?.title = character.polishCharacterName
        navigationController?.pushViewController(characterVC, animated: true)
        
    }
}

extension RobotsMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2 ) - 30
        let height = CGFloat(150)
    
        return CGSize(width: width, height: height)
    }
    
}

