//
//  SportsTabViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/21/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SportsTabViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource{
   
    var arrResult: [SportModel] = [SportModel]()
    
    @IBOutlet var collectionView: UICollectionView!
    //var arrRes = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SportsCstmCollectionViewCell.nib(), forCellWithReuseIdentifier: "sportsCellCollView")
        
        
        
        // API
        //https://www.thesportsdb.com/api/v1/json/1/all_sports.php
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php").validate().responseJSON  {response in
            switch response.result{
            case .success:
                let data = try? JSON (data:response.data!)
                let list = data!["sports"]
                for i in list.arrayValue{
                    var s = SportModel(image: i["strSportThumb"].stringValue, title: i["strSport"].stringValue)
                   // s.title = i["strSport"].stringValue
                   // s.image=i["strSportThumb"].stringValue
                   self.arrResult.append(s)
                }
                DispatchQueue.main.async {
                     self.collectionView.reloadData()
                }
               // print(self.arrResult)
               
                break
            case .failure(_):
                print(response.error)
                break
            }
        }
       
}
    
    // collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       // print( indexPath.row)
       let leagues = (self.storyboard?.instantiateViewController(withIdentifier: "leagues") as!LeaguesViewController)
         leagues.strSport=arrResult[indexPath.row].title
       self.navigationController?.pushViewController(leagues, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print(arrResult.count)
        return arrResult.count;
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportsCellCollView", for: indexPath)as!SportsCstmCollectionViewCell
        
        
        let currentSport = arrResult[indexPath.row]
        //print(currentSport)
        cell.setCustomCellSportsData(with: currentSport)
       // cell.titleSportLabel.text = currentSport.title
        
        //cell.imageCustomCell
        return cell
    }
 

}

