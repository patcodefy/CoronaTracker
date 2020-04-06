//
//  StatsCollectionViewCell.swift
//  CoronaTracker
//
//  Created by pat on 3/28/20.
//  Copyright © 2020 pat. All rights reserved.
//

import UIKit

class StatsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleUILabel: UILabel!
    @IBOutlet weak var statsUILabel: UILabel!
    @IBOutlet weak var backgroundUILabel: UILabel!
    var cellData:StatsCellData! {
        didSet {
            titleUILabel.text = cellData.title.uppercased()
            statsUILabel.text = "\(cellData.stats)"
            backgroundUILabel.borderWidth = 0.5
            backgroundUILabel.borderColor = .darkGray
            backgroundUILabel.cornerRadius = 5
            
        }
    }
    
}
