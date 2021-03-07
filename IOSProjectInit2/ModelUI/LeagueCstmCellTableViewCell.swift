//
//  LeagueCstmCellTableViewCell.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/21/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

protocol PlayerDelegate : AnyObject{
    func playYoutubeBtnDelegate(with str :String)
    
}

class LeagueCstmCellTableViewCell: UITableViewCell {
    

    weak var delegate:PlayerDelegate?
    var temp : String = " "

    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var leagueTitle: UILabel!
    
    
    @IBAction func playYoutubeBtn(_ sender: Any) {
        delegate?.playYoutubeBtnDelegate(with:temp)
         //print("btn clicked")
        //let playYoutube = PlayVideoViewController() //change this to your class name
       // self.presentViewController(playYoutube, animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
    public func setCustomCellLeaguesData(with model: LeagueModel) {
     
        do{
           // leagueImg.image = UIImage( data: try Data(contentsOf: URL(string: model.image )!))
            //sd web image
            leagueImg.sd_setImage(with: URL(string: model.image)!, completed: nil)
            //cell.leagueImg.sd_setImag(with: URL(string: model.image ) ,placeholderImage: UIImage(named: ""))
            leagueImg.sd_setImage(with: URL(string: model.image), placeholderImage: UIImage(named: "SDWebImage_logo_small"))
            leagueImg.layer.borderWidth = 1
            leagueImg.layer.masksToBounds = false
            leagueImg.layer.borderColor = UIColor.black.cgColor
            leagueImg.layer.cornerRadius = leagueImg.frame.height/2
            leagueImg.clipsToBounds = true
         }catch{
            
        }
        leagueTitle.text = model.title
        self.temp = model.youtubeURL
    }
    static func nib() -> UINib{
        return UINib(nibName:"LeagueCstmCellTableViewCell", bundle: nil)
    }

}
