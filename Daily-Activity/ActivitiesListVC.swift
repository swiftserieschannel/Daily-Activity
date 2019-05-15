//
//  ActivitiesListVC.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit

struct cellData {
    
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class ActivitiesListVC: UIViewController {
 
    var tableViewData = [cellData]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: categoryArr[0], sectionData: subCategory[0]),
        cellData(opened: false, title: categoryArr[1], sectionData: subCategory[1]),
        cellData(opened: false, title: categoryArr[2], sectionData: subCategory[2]),
        cellData(opened: false, title: categoryArr[3], sectionData: subCategory[3])]
        // Do any additional setup after loading the view.
    }
    

   

}


//MARK:- UItableView dataSource and Delegate methods.
extension ActivitiesListVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityListCell")else { return  UITableViewCell()}
            
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityListCell")else { return  UITableViewCell()}
            
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
             return cell
        }
       
        
       
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        if tableViewData[indexPath.section].opened == true {
           tableViewData[indexPath.section].opened = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
            
        }else {
            tableViewData[indexPath.section].opened = true
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
        }
        }
            
    }
    
}
