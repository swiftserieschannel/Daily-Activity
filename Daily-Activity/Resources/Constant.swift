//
//  Constant.swift

import Foundation
import UIKit


let storyBoard         =      UIStoryboard(name: "Main", bundle: nil)
let appDelegate        =      UIApplication.shared.delegate as? AppDelegate
var categoryArr = ["Sports" , "Gym" , "Reading" , "Cooking"]
var subCategory = [["Cricket" , "Golf" , "Football" , "Tennis"] , ["CrossFit" , "Cardio" , "Weight-Lifting" , "Yoga"], ["News" , "Articles" , "Books"], ["Indian" , "French"]]



struct AppConstant {
     static let  appNavigationBarColor = UIColor(red: 175/255, green: 35/255, blue: 42/255, alpha: 1.0)
}

struct AppFont {
    
    static let regular                         = "Helvetica-Regular"
    static let light                           = "Helvetica-Light"
    static let bold                            = "Helvetica-Bold"
    static let italic                          = "Helvetica-Italic"
}


extension UIViewController {

    func setNavigationbarTitle(navigationTitle: String) {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,  NSAttributedString.Key.font: UIFont(name: AppFont.bold, size: 18)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       navigationController?.navigationBar.barTintColor = AppConstant.appNavigationBarColor
        self.navigationController?.visibleViewController?.navigationItem.title = navigationTitle
    }
}



