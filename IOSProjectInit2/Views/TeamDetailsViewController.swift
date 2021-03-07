//
//  TeamDetailsViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    var team :TeamBadgeModel?
    

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var subNamesLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var establishedLabel: UILabel!
    @IBOutlet weak var sportName: UILabel!
    
    @IBOutlet weak var stadiumLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text = team!.teamName
       // subNamesLabel.text = team?.subNames
       // countryLabel.text = team!.stadiumLoc
        establishedLabel.text = team!.established
        sportName.text = team!.sportName
        stadiumLabel.text = team!.stadium
       
        
        do{
            image.image = UIImage( data: try Data(contentsOf: URL(string: team!.image )!) )
            image.layer.borderWidth = 0
            image.layer.masksToBounds = false
           // imageCustomCell.layer.borderColor = UIColor.black.cgColor
            image.layer.cornerRadius = image.frame.height/2
            image.clipsToBounds = true
        }catch{
           
            
        }
        

        // calling api teamsDetails by id
        
        // Do any additional setup after loading the view.
    }
    

   

}
