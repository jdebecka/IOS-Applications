//
//  CharacterCollectionViewCell.swift
//  Roboty
//
//  Created by Julia Debecka on 11/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import SnapKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    enum character {
        case radek, panDekiel, paniDekiel, gwozdziu, tex
    }
    
        let polishCharacterLabel: UILabel = {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.font = .systemFont(ofSize: 15, weight: .bold)
            lb.textColor = #colorLiteral(red: 0.1283391118, green: 0.3100302815, blue: 0.6000891328, alpha: 1)
            lb.text = "Radek Dekiel"
            return lb
        }()
    
    let characterLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = #colorLiteral(red: 0.1283391118, green: 0.3100302815, blue: 0.6000891328, alpha: 1)
//        lb.font = UIFont(name: "Khmer Sangam MN", size: 15)
        lb.font = .systemFont(ofSize: 13, weight: .light)
        lb.text = "Radek Dekiel"
        return lb
    }()
    
//    let imageView: UIImageView = {
//        let iv = UIImageView()
//        let image = #imageLiteral(resourceName: "RodneyCopperbottom")
//        iv.image = image
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.clipsToBounds = true
//        iv.contentMode = .scaleAspectFit
//        return iv
//    }()
}

fileprivate extension CharacterCollectionViewCell {
    func setup() {
        contentView.addSubview(polishCharacterLabel)
        contentView.addSubview(characterLabel)
        
//        contentView.addSubview(imageView)
        self.backgroundColor = #colorLiteral(red: 0.9051800966, green: 0.9189704061, blue: 0.9469152093, alpha: 1)
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        setupSnapkit()
    }
    
    func setupSnapkit() {
        
        polishCharacterLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.contentView.snp.top).offset(30)
            maker.centerX.equalTo(self.contentView.snp.centerX)
        }
        
        characterLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(polishCharacterLabel.snp.bottom).offset(10)
            maker.centerX.equalTo(self.contentView.snp.centerX)
        }
        
//        imageView.snp.makeConstraints { (maker) in
//            maker.height.equalTo(snp.width).multipliedBy(0.70)
//            maker.bottom.equalTo(self.contentView).offset(-10)
//            maker.top.equalTo(characterLabel.snp.bottom)
//            maker.centerX.equalTo(self.contentView)
//        }
    }
    
    func setUpBackgroud() {
        
    }
    
//    func getGradientLayer() -> CAGradientLayer {
//        let colors = [CGColor(srgbRed: 225/255, green: 229/255, blue: 238/255, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.2666666667, blue: 0.5647058824, alpha: 1)]
////        let colors = [CGColor(srgbRed: 0.6717405319, green: 0.9272100329, blue: 0.9266932011, alpha: 1), CGColor(srgbRed: 0.08964873105, green: 0.1766746938, blue: 0.4366246462, alpha: 0.9990234375)]
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.frame = self.bounds
//        return gradientLayer
//    }
}
