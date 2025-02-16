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

//MARK: - DB CONSTANT KEYS
class DBConstantKeys{
    public static let entityName            = "DailyActivities"
    public static let parentActivityName    = "parentActivityName"
    public static let subActivityName       = "subActivityName"
    public static let comments              = "comments"
    public static let date                  = "date"
    public static let startTime             = "startTime"
    public static let isEnded               = "isEnded"
    public static let endTime               = "endTime"
    public static let durationInMinutes     = "durationInMinutes"
    public static let startTimeStamp        = "startTimeStamp"
    public static let endTimeStamp          = "endTimeStamp"
}

class DBManager { // it's a singleton class which going to manage DB Transactions
    
    // Mark: - properties
    // shared variable to access instance of DBManager
    public static let shared:DBManager = DBManager()
    // db context
    private let nscontext = ((UIApplication.shared.delegate) as!
        AppDelegate).persistentContainer.viewContext
    
    // Mark: - init
    private init(){}
    
    // Mark: - instance methods
    // add new activity
    public func addActivity(parentActivityName:String, subActivityName:String?,comments:String, startDate:String, startTime:String, startTimeStamp:String) -> Bool{
        let entity = NSEntityDescription.insertNewObject(forEntityName: DBConstantKeys.entityName,into: nscontext)
        entity.setValue(parentActivityName, forKey: DBConstantKeys.parentActivityName)
        entity.setValue(subActivityName, forKey: DBConstantKeys.subActivityName)
        entity.setValue(comments, forKey: DBConstantKeys.comments)
        entity.setValue(startDate, forKey: DBConstantKeys.date)
        entity.setValue(startTime, forKey: DBConstantKeys.startTime)
        entity.setValue("NO", forKey: DBConstantKeys.isEnded)
        entity.setValue(startTimeStamp, forKey: DBConstantKeys.startTimeStamp)
        do
        {
            try nscontext.save()
        }catch {
            debugPrint("exception while inserting activity into database!")
            return false
        }
        return true
    }
    
    // update activity if its going to be ended
    public func updateEndedActivity(endTime:String,durationInMinutes:Int,endTimeStamp:String) -> Bool{
        let entityDescription = NSEntityDescription.entity(forEntityName: DBConstantKeys.entityName,in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        request.entity = entityDescription
        let pred = NSPredicate(format: "isEnded =%@", "NO")
        request.predicate = pred
        do{
            let result = try nscontext.fetch(request)
            if result.count > 0 {
                let manage = result[0] as! NSManagedObject
                manage.setValue("YES", forKey: DBConstantKeys.isEnded)
                manage.setValue(endTime, forKey: DBConstantKeys.endTime)
                manage.setValue(String(describing: durationInMinutes), forKey: DBConstantKeys.durationInMinutes)
                manage.setValue(endTimeStamp, forKey: DBConstantKeys.endTimeStamp)
                try nscontext.save()
            }else{
                debugPrint("No activity found to update end actity")
                return false
            }
        }catch{
            debugPrint("exception while updating activity to end the activity!")
            return false
        }
        return true
    }
    
    // get activities by date
    public func searchActivityByDate(date:String) -> [NSManagedObject]{
        let entityDescription = NSEntityDescription.entity(forEntityName: DBConstantKeys.entityName,in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        request.entity = entityDescription
        let pred = NSPredicate(format: "date =%@", date)
        request.predicate = pred
        do {
            return try nscontext.fetch(request) as! [NSManagedObject]
        }catch {
            debugPrint("error while fetching activities on the basis of date!")
            return []
        }
    }
    // retrieve all activities from database
    public func getAllActivities() -> [NSManagedObject]{
        let entityDescription = NSEntityDescription.entity(forEntityName: DBConstantKeys.entityName,in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        request.entity = entityDescription
        do {
            return try nscontext.fetch(request) as! [NSManagedObject]
        }catch {
            debugPrint("error while fetching activities on the basis of date!")
            return []
        }
    }
    
    // clear DB Data
    public func clearAllActivities() -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try nscontext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                nscontext.delete(objectData)
            }
            return true
        } catch let error {
            debugPrint("Detele all data in \(DBConstantKeys.entityName) error :", error)
            return false
        }
    }
    // check if any activity is runing in DB
    public func isAnyActivityRuning() -> Bool {
        let entityDescription = NSEntityDescription.entity(forEntityName: DBConstantKeys.entityName,in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        request.entity = entityDescription
        let pred = NSPredicate(format: "isEnded =%@", "NO")
        request.predicate = pred
        do {
            let activities = try nscontext.fetch(request) as! [NSManagedObject]
            return activities.count > 0 ? true : false
        }catch {
            debugPrint("error while fetching activities on the basis of date!")
            return false
        }
    }
    
    // stop activities that are runing from previous days
    public func stopLongRuningActivities(runingActivity:NSManagedObject)->Bool{
        let entityDescription = NSEntityDescription.entity(forEntityName: DBConstantKeys.entityName,in: nscontext)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DBConstantKeys.entityName)
        request.entity = entityDescription
        let pred = NSPredicate(format: "isEnded =%@", "NO")
        request.predicate = pred
        do{
            let result = try nscontext.fetch(request)
            if result.count > 0 {
                let manage = result[0] as! NSManagedObject
                // calculating activity end timestamp
                let startTimeStamp = runingActivity.value(forKey: DBConstantKeys.startTimeStamp) as! String
                manage.setValue("YES", forKey: DBConstantKeys.isEnded)
                manage.setValue("11:59", forKey: DBConstantKeys.endTime)
                let endTimeStamp = Utile.getTimeStamp(forDate: runingActivity.value(forKey: DBConstantKeys.date) as! String, forTime: runingActivity.value(forKey: DBConstantKeys.endTime) as! String)
                manage.setValue(Utile.timeDifference(start: startTimeStamp, end: endTimeStamp).description, forKey: DBConstantKeys.durationInMinutes)
                manage.setValue(endTimeStamp, forKey: DBConstantKeys.endTimeStamp)
                try nscontext.save()
            }else{
                debugPrint("No activity found to update end actity")
                return false
            }
        }catch{
            debugPrint("exception while updating activity to end the activity!")
            return false
        }
        return true
    }
}
