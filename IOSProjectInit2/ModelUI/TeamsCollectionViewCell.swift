//
//  TeamsCollectionViewCell.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/28/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import SDWebImage

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCustomCellTeamsData(with model: TeamBadgeModel) {
        
        do{
            //teamImageView.image = UIImage( data: try Data(contentsOf: URL(string: model.image )!) )
           // teamImageView.sd_setImage(with: URL(string: model.image)!, completed: nil)
         teamImageView.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "SDWebImage_logo_small"))
            teamImageView.layer.borderWidth = 0
            teamImageView.layer.masksToBounds = false
           // teamImageView.layer.borderColor = UIColor.black.cgColor
            teamImageView.layer.cornerRadius = teamImageView.frame.height/2
            teamImageView.clipsToBounds = true
        }catch{
            
        }
        //titleSportLabel.text = model.title
        
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName:"TeamsCollectionViewCell", bundle: nil)    //name of xib file
        
    }


}
