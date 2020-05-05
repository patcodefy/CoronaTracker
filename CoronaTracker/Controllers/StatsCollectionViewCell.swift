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
            statsUILabel.text = formatNumber(number: cellData.stats)
            uiDesign()
            
        }
    }
    
    private func formatNumber(number: Int) -> String{
        return String(format: "%ld %@", locale: Locale.current, number, "")
    }
    
    private func uiDesign (){
        backgroundUILabel.borderWidth = 0.5
        backgroundUILabel.borderColor = .darkGray
        backgroundUILabel.cornerRadius = 5
    }
}
