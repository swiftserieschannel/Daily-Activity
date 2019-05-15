//
//  ViewController.swift
//  Daily-Activity
//
//  Created by prashant on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import UIKit

class ActivityHistoryVC : UIViewController {

    //MARK:- IBOutlets.
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addActivityBtn: NSLayoutConstraint!
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }




    @IBAction func addActivityBtnAction(_ sender: UIButton) {
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddActivityVC") as! AddActivityVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}


//MARK:- UITableView DataSource Methods.
extension ActivityHistoryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityHistoryCell", for: indexPath)
        
        
        return cell
    }
   
}

//MARK:- UITableView DElegates Methods.
extension ActivityHistoryVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
