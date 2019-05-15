//
//  AddActivityVC.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit
import DropDown

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
    
    //MARK:- lifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
     startBtn.layer.cornerRadius = 5.0
        self.navigationController?.isNavigationBarHidden = false
    setNavigationbarTitle(navigationTitle: "Add Activity")
        // Do any additional setup after loading the view.
    }
    
    
    func dropDownConfigration(_ sender : UIButton , _ dataArr : [String] )  {
    
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
            }else if sender.tag == 30{//subcategopry btn
                self.subActivityLbl.textColor = UIColor.black
              self.subActivityLbl.text = item
            }
        }
        dropDown.show()
        dropDown.cancelAction = { [] in
            
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
            }else{
                 dropDownConfigration(sender, subCategory[selectedIndex])
            }
        case 40 : //startBtn
            break
        default:
            break
        }
        
        
    }
}
