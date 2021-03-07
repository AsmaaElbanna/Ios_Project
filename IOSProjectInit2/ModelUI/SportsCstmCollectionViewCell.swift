//
//  SportsCstmCollectionViewCell.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/21/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import SDWebImage

class SportsCstmCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCustomCell: UIImageView!
    
    @IBOutlet weak var titleSportLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCustomCellSportsData(with model: SportModel) {
        
        do{
           // imageCustomCell.image = UIImage( data: try Data(contentsOf: URL(string: model.image )!) )
           // imageCustomCell.sd_setImage(with: URL(string: model.image)!, completed: nil)
            imageCustomCell.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "SDWebImage_logo_small"))
            imageCustomCell.layer.borderWidth = 1
            imageCustomCell.layer.masksToBounds = false
            imageCustomCell.layer.borderColor = UIColor.black.cgColor
            imageCustomCell.layer.cornerRadius = 20 //imageCustomCell.frame.height/2
            imageCustomCell.clipsToBounds = true
        }catch{
            
        }
        titleSportLabel.text = model.title
        
    }
 
    
    
    static func nib() -> UINib{
        return UINib(nibName:"SportsCstmCollectionViewCell", bundle: nil)
    }

}
