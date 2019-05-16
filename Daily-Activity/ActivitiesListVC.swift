//
//  ActivitiesListVC.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesListVC: UIViewController {
    
    //MARK:- Outlets..
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTF: UITextField!
    
    //MARK:- Variables.
    var rightBarBtn = UIBarButtonItem()
    let formatterForCurrentDate  = DateFormatter()
    let datePicker  = UIDatePicker()
    let currentDate  : NSDate = NSDate()
    
    //activites from DB
    var activities :[NSManagedObject]?
    var runingActivity :NSManagedObject?
    
    //MARK:- lifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // configuring navigation bar
        setNavigationbarTitle(navigationTitle: "Activities")
        addRightBarBtn()
        // date textfield view setup
        dateTF.tintColor = UIColor.clear
        dateTF.delegate = self
        dateTF.text = Utile.getCurrentDate()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // retrieve all activities from DB
        activities = DBManager.shared.searchActivityByDate(date: dateTF.text ?? Utile.getCurrentDate())
        
        isAnyActivityRuning = DBManager.shared.isAnyActivityRuning()
        runingActivity = getRunningActivity()
        self.tableView.reloadData()
    }
    
    //MARK:- Add Bar btn
    func addRightBarBtn() {
        rightBarBtn = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(moveToNextVC))
        
        navigationItem.rightBarButtonItems = [rightBarBtn]
    }
    
    @objc func moveToNextVC(){
        if !isAnyActivityRuning {
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
            isComeFromHistoryListVC = false
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.showAlert(message: "Already an activity is runing!")
        }
    }
    
    //MARK:- showDatePIcker.
    
    // settingup date picker
    func showDatePicker(){
        //Formate Date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        datePicker.datePickerMode = .date
        //set min or max date in date picker
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let components: NSDateComponents = NSDateComponents()
        components.year = -50
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        datePicker.maximumDate = currentDate as Date
        datePicker.minimumDate = minDate as Date
        
        
        //ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        view.bringSubviewToFront(toolBar)
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        
        formatterForCurrentDate.dateFormat = "dd-MM-yyyy"
        debugPrint(formatterForCurrentDate.string(from: currentDate as Date))
        
        dateTF.inputAccessoryView = toolBar
        dateTF.inputView = datePicker
        
    }
    
    // action for clicked on done button
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
        // get data from database for particular date
        activities = DBManager.shared.searchActivityByDate(date: dateTF.text ?? Utile.getCurrentDate())
        self.tableView.reloadData()
    }
    // action for clicked on cancel button
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    // MARK:- Helper methods
    // calculating total hour to show with parent activity name
    func calculateTotalHour(forParentActivity:String)->Double{
        var totalHours:Double = 0
        for obj in self.activities ?? [] {
            if obj.value(forKey: DBConstantKeys.parentActivityName) as! String == forParentActivity {
                if let duration = obj.value(forKey: DBConstantKeys.durationInMinutes) as? String{
                    totalHours += Double(duration)!
                }
            }
        }
        totalHours /= 60
        totalHours = Double(round(100*totalHours)/100)
        return totalHours
    }
    // fiter sub activities data according to selected parent activities
    func filterActivities(forParentActivity:String) -> [NSManagedObject]{
        var activities:[NSManagedObject] = []
        for obj in self.activities ?? [] {
            if obj.value(forKey: DBConstantKeys.parentActivityName) as! String == forParentActivity {
                activities.append(obj)
            }
        }
        return activities
    }
    // fetch the current runing activity
    func getRunningActivity() -> NSManagedObject?{
        for obj in self.activities ?? [] {
            if obj.value(forKey: DBConstantKeys.isEnded) as! String == "NO"{
                return obj
            }
        }
        return nil
    }
    
}

//MARK:- UItableView dataSource and Delegate methods.
extension ActivitiesListVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityListCell")else { return  UITableViewCell()}
        
        cell.textLabel?.text = categoryArr[indexPath.row]
        cell.detailTextLabel?.text = self.calculateTotalHour(forParentActivity: categoryArr[indexPath.row]).description.appending("hr")
        // any if activity runing related to current parent activity then change bg color
        if let runingActivity = self.runingActivity {
            if runingActivity.value(forKey: DBConstantKeys.parentActivityName) as! String  == categoryArr[indexPath.row]{
                cell.backgroundColor = UIColor.green.withAlphaComponent(0.4)
            }
            else{
                cell.backgroundColor = UIColor.white
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ActivityHistoryVC") as! ActivityHistoryVC
        vc.subActivities = filterActivities(forParentActivity: categoryArr[indexPath.row])
        vc.headerTitle = categoryArr[indexPath.row]
        vc.categorySection = indexPath.row
        if let runingActivity = self.runingActivity{
            vc.runingActivity = runingActivity
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK:- UItextField Delegates.
extension ActivitiesListVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker()
    }
}
