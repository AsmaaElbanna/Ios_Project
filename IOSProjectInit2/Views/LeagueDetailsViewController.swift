//
//  LeagueDetailsViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/18/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData


class LeagueDetailsViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    
     var arrResultTeamBadge: [TeamBadgeModel] = [TeamBadgeModel]()
     var arrResultLastEvents: [LastEventModel] = [LastEventModel]()
     var arrResultUpComing: [UpComingModel] = [UpComingModel]()
     //var leagueID : String?
    
     var leagModel : LeagueModel?
    
    var arrResultfromLeague: [LeagueModel] = [LeagueModel]()
    
    
    @IBOutlet weak var upComingCV: UICollectionView!
    @IBOutlet weak var latestResultCV: UICollectionView!
    @IBOutlet weak var teamsCV: UICollectionView!
    
    
    @IBOutlet weak var favOutlet: UIBarButtonItem!
  
    @IBAction func favouriteBtn(_ sender: UIBarButtonItem) {
        
       if(sender.tag == 1){
           sender.tag = 2
            favOutlet.image = UIImage(named: "heart48.png")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: manageContext)
            let favouriteleague = NSManagedObject(entity: entity!, insertInto: manageContext)
            //set objects of favourite
            favouriteleague.setValue(leagModel!.title, forKey:"title")
            favouriteleague.setValue(leagModel!.image, forKey: "image")
            favouriteleague.setValue(leagModel!.youtubeURL, forKey: "youtubeURL")
            favouriteleague.setValue(leagModel!.id, forKey: "id")
            do{
                try manageContext.save()
            }catch let error{
                print(error)
            }
       
        }else{
            var arrOfLeagueFav = [NSManagedObject]()
            sender.tag = 1
            favOutlet.image = UIImage(named: "48x48favo.png")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            //fetch request
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
            do{
                var arrOfLeagueFav = try manageContext.fetch(fetchRequest)
                for i in arrOfLeagueFav{
                    if(i.value(forKey: "id") as! String == leagModel!.id ){
                        manageContext.delete(i)
                    }
                }
            
               try manageContext.save()
               
            }catch let error{
                print(error)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UISwipeGestureRecognizer(target: self, action: #selector(handleTap))
        tap.direction = .right
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
        
       
        teamsCV.delegate = self
        teamsCV.dataSource = self
        teamsCV.register(TeamsCollectionViewCell.nib(), forCellWithReuseIdentifier: "teamsCellCollViewCell")
        
        latestResultCV.delegate = self
        latestResultCV.dataSource = self
        latestResultCV.register(LatesResultCollectionViewCell.nib(), forCellWithReuseIdentifier: "lastResultsEvent")
        
        upComingCV.delegate = self
        upComingCV.dataSource = self
        upComingCV.register(UpComingCollectionViewCell.nib(), forCellWithReuseIdentifier: "upComingEventIdentifier")
        
        //select all core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        //fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        //select specific data
        // let predicate = NSPredicate(format: "title == %@", "movie")
        //  fetchRequest.predicate = predicate
        
        do{
            
         var arrOfLeagueFav = try manageContext.fetch(fetchRequest)
            for i in arrOfLeagueFav{
                if(i.value(forKey: "id") as! String == leagModel!.id ){
                    favOutlet.image = UIImage(named: "heart48.png")
                    break
                }
            }
        }catch let error{
            print(error)
        }
        
        // API taem badge
        //https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League
    Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="+leagModel!.id).validate().responseJSON  {response in
            switch response.result{
            case .success:
                let data = try? JSON (data:response.data!)
                let list = data!["teams"]
                for i in list.arrayValue{
                    var s = TeamBadgeModel(image: i["strTeamBadge"].stringValue, teamName: i["strTeam"].stringValue, sportName: i["strSport"].stringValue, established: i["intFormedYear"].stringValue, stadiumLoc: i["strStadiumLocation"].stringValue, stadium: i["strStadium"].stringValue, subNames: i["strAlternate"].stringValue)
                    // s.title = i["strSport"].stringValue
                    // s.image=i["strSportThumb"].stringValue
                    self.arrResultTeamBadge.append(s)
                }
               //  print(self.arrResultTeamBadge)
                self.teamsCV.reloadData()
                break
            case .failure(_):
                print(response.error)
                break
            }
        }
        
        // API last Events
       //https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="+leagModel!.id).validate().responseJSON  {response in
            switch response.result{
            case .success:
                let data = try? JSON (data:response.data!)
                let list = data!["events"]
                for i in list.arrayValue{
                    
                    // object of lastEvent
                    var s = LastEventModel(homeTeam: i["strHomeTeam"].stringValue, homeScore: i["intHomeScore"].stringValue, awayTeam: i["strAwayTeam"].stringValue, awayScore: i["intAwayScore"].stringValue, date: i["dateEvent"].stringValue, time: i["strTime"].stringValue)
                    self.arrResultLastEvents.append(s)
                    // object of UpComingEvent
                    
                    var upcoming = UpComingModel(eventName: i["strEvent"].stringValue, date: i["dateEvent"].stringValue, time: i["strTime"].stringValue)
                    self.arrResultUpComing.append(upcoming)
                }
                // print(self.arrResultLastEvents)
                self.latestResultCV.reloadData()
                self.upComingCV.reloadData()
                break
            case .failure(_):
                print(response.error)
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(gesture: UISwipeGestureRecognizer) -> Void{
        /*
         let leagueVC = self.storyboard!.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
        leagueVC.arrResult = arrResultfromLeague
        self.navigationController?.pushViewController(leagueVC, animated: false)
        
       // let league = UINavigationController(rootViewController: leagueVC)
      //  self.present(league, animated:true, completion: nil)
      print("i am handleTap")
 */
       
            if gesture.direction == .right {
                self.dismiss(animated: true, completion: nil)
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == teamsCV){
         let teamDetails = self.storyboard!.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
       // teamDetails.leagueID=arrOfID[indexPath.row]
            //imageCustomCell.image = UIImage( data: try Data(contentsOf: URL(string: model.image )!))
           // var teamObj : TeamBadgeModel = TeamBadgeModel()
            teamDetails.team = arrResultTeamBadge[indexPath.row]
            print(arrResultTeamBadge[indexPath.row])
            
          //  if (teamObj.teamName != nil && teamObj.teamName.count != 0){
          //  }
          //  teamDetails.countryLabel.text = teamObj.stadiumLoc
           // print(teamObj.teamName)
         self.navigationController?.pushViewController(teamDetails, animated: true)
        // print(arrOfID[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == teamsCV){
             return arrResultTeamBadge.count
        } else if(collectionView == latestResultCV){
            return arrResultLastEvents.count
        }
       return arrResultUpComing.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == teamsCV){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCellCollViewCell", for: indexPath)as!TeamsCollectionViewCell
        let currentTeam = arrResultTeamBadge[indexPath.row]
        //print(currentTeam)
        cell.setCustomCellTeamsData(with: currentTeam)
        // cell.titleSportLabel.text = currentSport.title
        //cell.imageCustomCell
            cell.layer.borderWidth = 1
            cell.layer.borderWidth = 1
            cell.layer.masksToBounds = false
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 20   //imageCustomCell.frame.height/2
            cell.clipsToBounds = true
            
        return cell
        }
       // print("Done")
      else if (collectionView == latestResultCV){
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastResultsEvent", for: indexPath)as! LatesResultCollectionViewCell
            let currentLatstEvent = arrResultLastEvents[indexPath.row]
           // print(currentLatstEvent)
            cell.setCustomCellLatestRes(with: currentLatstEvent)
            cell.layer.borderWidth = 1
            cell.layer.borderWidth = 1
            cell.layer.masksToBounds = false
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 20   //imageCustomCell.frame.height/2
            cell.clipsToBounds = true
            
    
            return cell
       }
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingEventIdentifier", for: indexPath) as! UpComingCollectionViewCell
        let currentUpComingEvent = arrResultUpComing[indexPath.row]
        cell.setCustomCellUpComing(with: currentUpComingEvent)
        
        cell.layer.borderWidth = 1
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = false
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20   //imageCustomCell.frame.height/2
        cell.clipsToBounds = true
        
        
       return cell

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
