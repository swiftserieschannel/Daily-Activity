//
//  File.swift
//  Daily-Activity
//
//  Created by chander bhushan on 15/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DBManager { // it's a singleton class which going to manage DB Transactions
    
    // Mark: - properties
    // shared variable to access instance of DBManager
    public static var shared:DBManager = DBManager()
    // db context
    private let nscontext = ((UIApplication.shared.delegate) as!
        AppDelegate).persistentContainer.viewContext
    
    // Mark: - init
    private init(){}
    
    // Mark: - instance methods
    // add new activity
    public func addActivity(parentActivityName:String, subActivityName:String?,comments:String, startDate:String, startTime:String) -> Bool{
        let entity = NSEntityDescription.insertNewObject(forEntityName: "DailyActivities",into: nscontext)
        entity.setValue(parentActivityName, forKey: "parentActivityName")
        entity.setValue(subActivityName, forKey: "subActivityName")
        entity.setValue(comments, forKey: "comments")
        entity.setValue(startDate, forKey: "date")
        entity.setValue(startTime, forKey: "startTime")
        do
        {
            try nscontext.save()
        }catch {
            print("exception while inserting activity into database!")
            return false
        }
        return true
    }
    
    // update activity if its going to be ended
    public func updateEndedActivity(endTime:String,durationInMinutes:Int) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: "DailyActivities",in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyActivities")
        request.entity = entity
        let pred = NSPredicate(format: "isEnded =%@", false)
        request.predicate = pred
        do{
            let result = try nscontext.fetch(request)
            if result.count > 0 {
                let manage = result[0] as! NSManagedObject
                manage.setValue(true, forKey: "isEnded")
                manage.setValue(endTime, forKey: "endTime")
                manage.setValue(String(describing: durationInMinutes), forKey: "durationInMinutes")
                try nscontext.save()
            }else{
                print("No activity found to update end actity")
                return false
            }
        }catch{
            print("exception while updating activity to end the activity!")
            return false
        }
        return true
    }
    
    // get activities by date
    public func searchActivityByDate(date:String){
        let entity = NSEntityDescription.entity(forEntityName: "DailyActivities",in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyActivities")
        request.entity = entity
        let pred = NSPredicate(format: "date =%@", date)
        request.predicate = pred
        
    }
}
