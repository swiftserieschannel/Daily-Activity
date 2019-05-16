//
//  Utile.swift
//  Swift
//
//  Created by prashant on 14/12/18.
//
import  UIKit

struct Utile {
    
    static let getWindow = UIApplication.shared.windows.first
    static let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    
    /// This method is used to get object if AppDelegate
    ///
    /// - returns: Object of AppDelegate
    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK:- manage FontSize According to iphone's screen
    static func getFontSizeAcordingToDevices( currentFontSize: CGFloat) -> CGFloat {
        var fontSize = CGFloat(0)
        switch UIDevice.screenType {
    
        case .iPhones_5_5s_5c_SE:
            fontSize = currentFontSize - 2
    
        case .iPhoneXR:
            fontSize = currentFontSize + 3
    
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            fontSize = currentFontSize + 1
    
        case .iPhoneX_iPhoneXS:
            fontSize = currentFontSize - 0.3
    
        case .iPhoneXSMax:
            fontSize = currentFontSize + 3
        default:
            fontSize = currentFontSize
        }
        return fontSize
    }
    
    
    
    /// This method add constraints on activity indicator
    ///
    /// - parameter view: Indicator view
    fileprivate static func addConstraint(_ view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint.init(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 1)
        horizontalConstraint.isActive = true
        
        let verticalConstraint = NSLayoutConstraint.init(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: 1)
        verticalConstraint.isActive = true
        
    }
    
    // check connectivity.
//    static func isInternetAvailable() -> Bool {
//        return (NetworkReachabilityManager()?.isReachable ?? false)
//    }
    
    
    /// This method used to get device language code
    ///
    /// - Returns: deviceLanguageCode
    static func deviceLanguageCode() -> String {
        return Locale.current.languageCode ?? "en"
    }
    
    /// This method used to get device language
    ///
    /// - Returns: deviceLanguage
    static func deviceLanguage() -> String {
        return Locale.current.localizedString(forLanguageCode: deviceLanguageCode()) ?? "English"
    }
    
  static func getCurrentViewController() -> UIViewController? {
        let window = UIApplication.shared.windows.first
        let rootVC = window?.rootViewController
        var currentVC:UIViewController?
        
        if rootVC is UINavigationController {
            let navController = rootVC as! UINavigationController
            currentVC = navController.visibleViewController
        } else if rootVC != nil {
            currentVC = rootVC
        }
        return currentVC
    }
    
    //set navigation bar for hole app.
   static func setNavigationbarApperance() {
        let navigationAppearance = UINavigationBar.appearance()
        navigationAppearance.tintColor = UIColor.white
        navigationAppearance.barTintColor = UIColor(red: 175/255, green: 35/255, blue: 42/255, alpha: 1.0)
        navigationAppearance.shadowImage = UIImage()
        navigationAppearance.isTranslucent = false
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }
    
   
    // get current Timestamp
    static func getCurrentTimeStamp()->String{
        let date = Date().timeIntervalSince1970
        return date.description
    }
    // get current date in specified format
    static func getCurrentDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    // get current time in hrs and minutes
    static func getCurrentTime()->String{
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: now)
        return timeString
    }
    // time difference between two times
    static func timeDifference(start:String,end:String) -> Int{
       let startTimeInterval = TimeInterval(start)!
        let endTimeInterval = TimeInterval(end)!
        let diff = Int(endTimeInterval - startTimeInterval)
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        return minutes
    }
}
