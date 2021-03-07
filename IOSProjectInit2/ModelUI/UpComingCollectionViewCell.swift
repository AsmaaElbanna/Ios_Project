//
//  UpComingCollectionViewCell.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/28/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class UpComingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCustomCellUpComing(with model: UpComingModel) {
        
       
        eventNameLabel.text = model.eventName
        dateLabel.text = model.date
        timeLabel.text = model.time
        
        
     
    }
    
    
    
    static func nib() -> UINib{
        return UINib(nibName:"UpComingCollectionViewCell", bundle: nil)    //name of xib file
        
    }

    

}
