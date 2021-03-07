//
//  LatesResultCollectionViewCell.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/28/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class LatesResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setCustomCellLatestRes(with model: LastEventModel) {
        
        homeTeamLabel.text = model.homeTeam
        homeScoreLabel.text = model.homeScore
        awayTeamLabel.text = model.awayTeam
        awayScoreLabel.text = model.awayScore
        dateLabel.text = model.date
        timeLabel.text = model.time
        
        
    }
    
    
    
    static func nib() -> UINib{
        return UINib(nibName:"LatesResultCollectionViewCell", bundle: nil)    //name of xib file
        
    }

}
