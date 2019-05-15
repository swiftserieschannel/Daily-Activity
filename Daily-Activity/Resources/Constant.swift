//
//  Constant.swift

import Foundation
import UIKit


let storyBoard         =      UIStoryboard(name: "Main", bundle: nil)
let appDelegate        =      UIApplication.shared.delegate as? AppDelegate
var categoryArr = ["Sports" , "Gym" , "Reading" , "Cooking"]
var subCategory = [["Cricket" , "Golf" , "Football" , "Tennis"] , ["CrossFit" , "Cardio" , "Weight-Lifting" , "Yoga"], ["News" , "Articles" , "Books"], ["Indian" , "French"]]
struct AppConstant {
  
}

struct AppFont {
    
    static let regular                         = "Helvetica-Regular"
    static let light                           = "Helvetica-Light"
    static let bold                            = "Helvetica-Bold"
    static let italic                          = "Helvetica-Italic"
}


struct ControllersNames {
   
 
}



struct KEYS {
    
}

struct ScreenTitle {
   

}





struct Alerts {
    
  
}

extension UIViewController {

    func setNavigationbarTitle(navigationTitle: String) {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,  NSAttributedString.Key.font: UIFont(name: AppFont.bold, size: 18)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.visibleViewController?.navigationItem.title = navigationTitle
    }
}



