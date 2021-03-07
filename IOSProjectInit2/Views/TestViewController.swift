//
//  TestViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 3/5/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    
    @IBOutlet weak var btnOutlet: UIBarButtonItem!
    
    @IBAction func favAction(_ sender: Any) {
        
     btnOutlet.image = UIImage(named: "heart48.png")
        
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
