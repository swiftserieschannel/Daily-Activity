//
//  ViewController.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit

var isComeFromHistoryListVC = false

class ActivityHistoryVC : UIViewController {

    //MARK:- IBOutlets.
    @IBOutlet weak var tableView: UITableView!
    var headerTitle  : String?
    var categorySection : Int?

    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbarTitle(navigationTitle: headerTitle ?? "Activity")
        // Do any additional setup after loading the view.
    }




    
    
    
}


//MARK:- UITableView DataSource Methods.
extension ActivityHistoryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subCategory[categorySection ?? 0]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityHistoryCell", for: indexPath)
        
        let activityNameLbl = cell.viewWithTag(100) as! UILabel
        let startDateLbl = cell.viewWithTag(200) as! UILabel
        let endDateLbl = cell.viewWithTag(300) as! UILabel
        
        activityNameLbl.text = subCategory[categorySection ?? 0][indexPath.row]
        
        return cell
    }
   
}

//MARK:- UITableView DElegates Methods.
extension ActivityHistoryVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
        isComeFromHistoryListVC = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
