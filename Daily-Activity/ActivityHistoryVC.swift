//
//  ViewController.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit
import CoreData
var isComeFromHistoryListVC = false

class ActivityHistoryVC : UIViewController {
    
    //MARK:- IBOutlets.
    @IBOutlet weak var tableView: UITableView!
    var headerTitle  : String?
    var categorySection : Int?
    // activities coming from previous screen
    var subActivities:[NSManagedObject] = []
    var runingActivity:NSManagedObject?
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbarTitle(navigationTitle: headerTitle ?? "Activity")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
      
}


//MARK:- UITableView DataSource Methods.
extension ActivityHistoryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (subCategory[categorySection ?? 0]).count
        return subActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityHistoryCell", for: indexPath)
        // get activity for particular row
        let obj = subActivities[indexPath.row]
        // getting views by their tags
        let activityNameLbl = cell.viewWithTag(100) as! UILabel
        let startDateLbl = cell.viewWithTag(200) as! UILabel
        let endDateLbl = cell.viewWithTag(300) as! UILabel
        let bgView      = cell.viewWithTag(400) as! UIView
        // set the extracted db data on cell
        activityNameLbl.text = (obj.value(forKey: DBConstantKeys.subActivityName) as! String)
        startDateLbl.text   = (obj.value(forKey: DBConstantKeys.startTime) as! String)
        if let endTime = obj.value(forKey: DBConstantKeys.endTime) as? String{
            endDateLbl.text = endTime
        }
        // changing background color if activity current runing by comparing start timestamp
        if let runingActivity = self.runingActivity {
            if runingActivity.value(forKey: DBConstantKeys.startTimeStamp) as! String  == subActivities[indexPath.row].value(forKey: DBConstantKeys.startTimeStamp) as! String{
                bgView.backgroundColor = UIColor.green.withAlphaComponent(0.4)
            }
            else{
                bgView.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
}

//MARK:- UITableView DElegates Methods.
extension ActivityHistoryVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
        isComeFromHistoryListVC = true
        vc.endedActivity = subActivities[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
