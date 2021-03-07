//
//  FavouriteTabViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/16/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class FavouriteTabViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
   
     var arrOfLeagueFav = [NSManagedObject]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(LeagueCstmCellTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
            
           /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        //fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        //select specific data
        // let predicate = NSPredicate(format: "title == %@", "movie")
        //  fetchRequest.predicate = predicate
        
        do{
            arrOfLeagueFav = try manageContext.fetch(fetchRequest)
            
            }catch let error{
            print(error)
        }
 */
 
      // print(arrOfLeagueFav)
    //  print(arrOfLeagueFav[0].value(forKey: "title") as! String)
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return data.count
        return arrOfLeagueFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)as!LeagueCstmCellTableViewCell
        //cell.textLabel?.text=arrOfLeagueFav[indexPath.row].value(forKey: "title") as! String
        cell.leagueTitle.text = arrOfLeagueFav[indexPath.row].value(forKey: "title") as! String
       
        do{
            cell.leagueImg.image = UIImage( data: try Data(contentsOf: URL(string:arrOfLeagueFav[indexPath.row].value(forKey: "image") as! String )!))
         //   cell.leagueImg.layer.borderWidth = 1
          //  cell.leagueImg.layer.masksToBounds = false
          //  cell.leagueImg.layer.borderColor = UIColor.black.cgColor
           // cell.leagueImg.layer.cornerRadius = cell.leagueImg.frame.height/2
          //  cell.leagueImg.clipsToBounds = true
        }catch{
        }
       // cell.setCustomCellLeaguesData(with: arrOfLeagueFav[indexPath.row])
        return cell
    }
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

        if(NetworkMontior.shared.isConnected){
            print("internet is available")
            let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "details") as! LeagueDetailsViewController
            // print(arrResult[indexPath.row])
            
            var leagueModelObj = LeagueModel()
            leagueModelObj.id = arrOfLeagueFav[indexPath.row].value(forKey: "id") as! String
            leagueModelObj.title = arrOfLeagueFav[indexPath.row].value(forKey: "title") as! String
            leagueModelObj.youtubeURL = arrOfLeagueFav[indexPath.row].value(forKey: "youtubeURL") as! String
            leagueModelObj.image = arrOfLeagueFav[indexPath.row].value(forKey: "image") as! String
            detailsVC.leagModel = leagueModelObj
            
            let navController = UINavigationController(rootViewController: detailsVC)
            self.present(navController, animated:true, completion: nil)
        } else{
            print("internet is not available")
            // create the alert
            let alert = UIAlertController(title: " ", message: "No internet connection.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let manageContext = appDelegate.persistentContainer.viewContext
     //fetch request
     let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
     //select specific data
     // let predicate = NSPredicate(format: "title == %@", "movie")
     //  fetchRequest.predicate = predicate
     
     do{
     arrOfLeagueFav = try manageContext.fetch(fetchRequest)
     
     }catch let error{
     print(error)
     }
        self.tableView.reloadData()
    }
    

    
}
