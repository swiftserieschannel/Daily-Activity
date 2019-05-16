//
//  DummyData.swift
//  Daily-Activity
//
//  Created by chander bhushan on 16/05/19.
//  Copyright © 2019 swiftserieschannel. All rights reserved.
//

import Foundation

struct DummyData{
   static func insertData(){
        let inserted = DBManager.shared.addActivity(parentActivityName: "Sports", subActivityName: "Cricket", comments: "this is testing of db", startDate: "16-05-2019", startTime: "15:16", startTimeStamp: String(describing: 1558019801))
        print("data insertion is \(inserted)")
        
        print(DBManager.shared.updateEndedActivity(endTime: "16:16", durationInMinutes: Utile.timeDifference(start: String(describing: 1558019801), end: String(describing: 1558023641)), endTimeStamp: String(describing: 1558023641)))
        //
        let inserted1 = DBManager.shared.addActivity(parentActivityName: "Sports", subActivityName: "Football", comments: "this is testing of db", startDate: "16-05-2019", startTime: "17:25", startTimeStamp: String(describing: 1558027541))
        print("data insertion is \(inserted1)")
        print(DBManager.shared.updateEndedActivity(endTime: "17:55", durationInMinutes: Utile.timeDifference(start: String(describing: 1558027541), end: String(describing: 1558029341)), endTimeStamp: String(describing: 1558029341)))
    
    let inserted2 = DBManager.shared.addActivity(parentActivityName: "Sports", subActivityName: "Cricket", comments: "this is testing of db", startDate: "15-05-2019", startTime: "12:55", startTimeStamp: String(describing: 1557924941))
    print("data insertion is \(inserted2)")
    
    print(DBManager.shared.updateEndedActivity(endTime: "13:40", durationInMinutes: Utile.timeDifference(start: String(describing: 1557924941), end: String(describing: 1557927641)), endTimeStamp: String(describing: 1557927641)))
    //
    let inserted3 = DBManager.shared.addActivity(parentActivityName: "Reading", subActivityName: "News", comments: "this is testing of db", startDate: "15-05-2019", startTime: "14:40", startTimeStamp: String(describing: 1557931241))
    print("data insertion is \(inserted3)")
    print(DBManager.shared.updateEndedActivity(endTime: "16:20", durationInMinutes: Utile.timeDifference(start: String(describing: 1557931241), end: String(describing: 1557937241)), endTimeStamp: String(describing: 1557937241)))
    
    }
}
