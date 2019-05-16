//
//  ActivitiesListVC.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit

class ActivitiesListVC: UIViewController {
 
    //MARK:- Outlets..
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateTF: UITextField!
    
    //MARK:- Variables.
      var rightBarBtn = UIBarButtonItem()
      let formatterForCurrentDate  = DateFormatter()
      let datePicker  = UIDatePicker()
      let currentDate  : NSDate = NSDate()
    
    //MARK:- lifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbarTitle(navigationTitle: "Activities")
        addRightBarBtn()
        dateTF.tintColor = UIColor.clear
        dateTF.delegate = self
            
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Add Bar btn
    func addRightBarBtn() {
        rightBarBtn = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(moveToNextVC))
        
        navigationItem.rightBarButtonItems = [rightBarBtn]
    }

   @objc func moveToNextVC(){
    let vc = storyBoard.instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
    isComeFromHistoryListVC = false
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- showDatePIcker.
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
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
            return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "ActivityHistoryVC") as! ActivityHistoryVC
        vc.headerTitle = categoryArr[indexPath.row]
        vc.categorySection = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
            
    }
    
}

//MARK:- UItextField Delegates.
extension ActivitiesListVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showDatePicker()
    }
}
