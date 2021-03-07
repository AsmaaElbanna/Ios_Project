//
//  LeaguesViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/21/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import  Alamofire
import SwiftyJSON

class LeaguesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource , PlayerDelegate{
    func playYoutubeBtnDelegate(with str: String) {
        print("\(str)")
        let url = URL(string: "https://"+str)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)

        /*
      let playYoutube = self.storyboard?.instantiateViewController(withIdentifier: "play") as!PlayVideoViewController
       self.navigationController?.pushViewController(playYoutube, animated: false)
 */
    }
    var strSport: String = ""
    var arrOfID : [String] = [String]()
    var arrResult: [LeagueModel] = [LeagueModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(LeagueCstmCellTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
        
        print(strSport)
        
        //Api list all leagues
        //https://www.thesportsdb.com/api/v1/json/1/all_leagues.php
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php").validate().responseJSON  {response in
            switch response.result{
            case .success:
                let data = try? JSON (data:response.data!)
                let list = data!["leagues"]
                for i in list.arrayValue{
                    if(self.strSport == i["strSport"].stringValue){
                        var id = i["idLeague"].stringValue
                        self.arrOfID.append(id)
                        }
                    }
                DispatchQueue.main.async {
               self.callApiLeagueDetailsByID()
                }
                  // print(self.arrOfID)
                // self.collectionView.reloadData()
                
                //print(self.arrOfID)
                print(self.arrResult)
                break
            case .failure(_):
                print(response.error)
                break
            }
        }
        
        // end calling api all leagues
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print(arrResult.count)
        return arrResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)as!LeagueCstmCellTableViewCell
        
        var currentLeague = arrResult[indexPath.row]
       // print("image" + currentLeague.image)
        
        cell.setCustomCellLeaguesData(with: currentLeague)
        // cell.setCustomCellLeaguesData(with: data[indexPath.row])
        //cell.playYoutubeBtn(indexPath.row)
       //  cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        cell.delegate = self as! PlayerDelegate
        return cell
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        let playYoutube = (self.storyboard?.instantiateViewController(withIdentifier: "playYoutube") as! PlayVideoViewController)
        //details.movies=moviesOfList[indexPath.row]
        self.navigationController?.show(playYoutube, sender: nil)
        
    }
    */
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /*
    let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "details") as! LeagueDetailsViewController
        detailsVC.leagueID=arrOfID[indexPath.row]
    self.navigationController?.pushViewController(detailsVC, animated: true)
        print(arrOfID[indexPath.row])
 */
        
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "details") as! LeagueDetailsViewController
        print(arrResult[indexPath.row])
        detailsVC.leagModel = arrResult[indexPath.row]
        detailsVC.arrResultfromLeague = arrResult
        
        let navController = UINavigationController(rootViewController: detailsVC)
        self.present(navController, animated:true, completion: nil)
        
    }
    // Api league details by id
     // https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=
    func callApiLeagueDetailsByID(){
       //print(arrOfID.count)
        for i in arrOfID{
            
            let newURL : String = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="+i
           // print (newURL)
          //  print("go to hell")
            Alamofire.request(newURL).validate().responseJSON  {response in
                
                switch response.result{
                case .success:
                    let data = try? JSON (data:response.data!)
                    let list = data!["leagues"]
                    for i in list.arrayValue{
                      
                        var league = LeagueModel(image: i["strBadge"].stringValue, title:i["strLeague"].stringValue, youtubeURL: i["strYoutube"].stringValue, id: i["idLeague"].stringValue)
                       // print("image" + league.image)
                        if (league.image != nil && league.image.count != 0){
                         self.arrResult.append(league)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                   // print(self.arrOfID)
                    // self.collectionView.reloadData()
                  //  print(self.arrResult)
                    
                    break
                case .failure(_):
                    print(response.error)
                    break
                }
                // end calling api league details by id
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        print("i am viewDidAppear")
        print(arrResult)
    }
    
    
    
    
}


