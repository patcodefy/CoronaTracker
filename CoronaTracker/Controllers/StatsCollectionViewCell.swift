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
    var cellData:StatsCellData! {
        didSet {
            titleUILabel.text = cellData.title
            statsUILabel.text = "\(cellData.stats)"
        }
    }
    
}
