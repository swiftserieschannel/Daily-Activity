//
//  AddActivityVC.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit
import DropDown
import CoreData
class AddActivityVC: UIViewController {

    //MARK:- OUTLETS.
    @IBOutlet weak var activityLbl: LabelDesign!
    @IBOutlet weak var subActivityLbl: LabelDesign!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var commentTV: UITextView!
    @IBOutlet weak var subcategBtn: UIButton!
    
    //MARK:- variables.
    let dropDown  = DropDown()
    var selectedIndex = Int()
    
    var endedActivity:NSManagedObject?
    
    //MARK:- lifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
      //  commentTV.delegate = self
     startBtn.layer.cornerRadius = 5.0
        self.navigationController?.isNavigationBarHidden = false
    setNavigationbarTitle(navigationTitle: "Add Activity")
       commentTV.layer.borderWidth = 0.5
        commentTV.layer.borderColor = UIColor.gray.cgColor
        commentTV.layer.cornerRadius = 5.0
        
        // change start stop button state accordingly
        manageUIData()
    }
    
    
    // manage ui data according to started or stopped activity
    func manageUIData(){
        if isComeFromHistoryListVC {
            commentTV.isUserInteractionEnabled = false
            if let activity = endedActivity {
                if activity.value(forKey: DBConstantKeys.isEnded) as! String == "YES"{
                    self.populateData()
                    startBtn.isHidden = true
                }else{
                    self.populateData()
                    startBtn.isHidden = false
                    startBtn.setTitle("Stop", for: .normal)
                }
            }else{
                print("subactivity detail not found to populate!")
            }
            
        }else{
            commentTV.isUserInteractionEnabled = true
            startBtn.isHidden = false
            startBtn.titleLabel?.text = "Start"
        }
    }
    
    // populate data if came from history list of activities
    func populateData(){
        guard let obj = endedActivity else{
            return
        }
        activityLbl.text = obj.value(forKey: DBConstantKeys.parentActivityName) as? String
        subActivityLbl.text = obj.value(forKey: DBConstantKeys.subActivityName) as? String
        commentTV.text = obj.value(forKey: DBConstantKeys.comments) as? String
        startBtn.isHidden = true
    }
    
    
    func dropDownConfigration(_ sender : UIButton , _ dataArr : [String] )  {
        if !isComeFromHistoryListVC  {
        dropDown.dataSource = dataArr
        dropDown.anchorView = sender
//        dropDown.width = 100
//        dropDown.bottomOffset = CGPoint(x: -70, y: 10)
        dropDown.backgroundColor = UIColor.white
        dropDown.selectedTextColor = UIColor.white
        //dropDown.selectionBackgroundColor = UIColor.dropDownSelectedColor
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            debugPrint("Selected item: \(item) at index: \(index)")
            if sender.tag == 20 {//category btn
                self.selectedIndex = index
                 self.activityLbl.textColor = UIColor.black
                self.activityLbl.text = item
                self.subActivityLbl.textColor = UIColor.black
                self.subActivityLbl.text = subCategory[self.selectedIndex][0]
            }else if sender.tag == 30{//subcategopry btn
              self.subActivityLbl.text = item
            }
        }
        dropDown.show()
        dropDown.cancelAction = { [] in
            
        }
        }
    }
    

    //MARK:- screenBtn actions.
    @IBAction func screenBtnActions (_ sender : UIButton) {
        switch sender.tag {
        case 20:
            dropDownConfigration(sender, categoryArr)
        case 30:
            if activityLbl.text == "Select" || activityLbl.text?.trimmingCharacters(in: .whitespaces) == ""  {
             //alert
                self.showAlert(message: "Please select activity")
            }else{
                 dropDownConfigration(sender, subCategory[selectedIndex])
            }
        case 40 : //startBtn
            if sender.titleLabel?.text == "Start"{ // create new activity in DB
                let inserted = DBManager.shared.addActivity(parentActivityName: activityLbl.text ?? "", subActivityName: subActivityLbl.text ?? "", comments: commentTV.text, startDate: Utile.getCurrentDate(), startTime: Utile.getCurrentTime(), startTimeStamp: Date().timeIntervalSince1970.description)
                print(inserted ? "activity added successfully":"activity not added")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivitiesListVC") as! ActivitiesListVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sender.title(for: .normal) == "Stop"{ // stop started activity
                if let obj = endedActivity {
                    let endTimeStamp = Date().timeIntervalSince1970.description
                    let timeDiff = Utile.timeDifference(start: obj.value(forKey: DBConstantKeys.startTimeStamp) as! String, end: Date().timeIntervalSince1970.description)
                    // update data in database to stop activity
                    let updated = DBManager.shared.updateEndedActivity(endTime: Utile.getCurrentTime(), durationInMinutes: timeDiff, endTimeStamp: endTimeStamp)
                    print(updated ? "Activity stopped":"error while stopping activity")
                   
                   self.navigationController?.popToRootViewController(animated: true) 
                }
            }
            
        default:
            break
        }
        
        
    }
}
