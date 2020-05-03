//
//  MainTableViewCell.swift
//  Joke Bank
//
//  Created by Julia Debecka on 04/04/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    var wineData: Wine.ArrayLiteralElement! {
        didSet {
            guard let wineData = wineData else { return }
            self.textLabel?.text = wineData.name
            let img = UIImage(named: wineData.picture)
            imageView?.image = img
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
