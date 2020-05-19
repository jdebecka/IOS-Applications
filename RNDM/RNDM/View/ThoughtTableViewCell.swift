//
//  ThoughtTableViewCell.swift
//  RNDM
//
//  Created by Julia Debecka on 15/05/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class ThoughtTableViewCell: UITableViewCell {
    @IBOutlet weak var usenameLbl: UILabel!
    @IBOutlet weak var thoughtLbl: UILabel!
    @IBOutlet weak var likeslbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        usenameLbl.text = "Julia D."
        thoughtLbl.text = "I like Parker Calvin Hicks so much! My heart is always full of happiness when I see his hansome face! ☺️"
        likeslbl.text = "1M"
        dateLbl.text = "\(Date())"
    }

}
