//
//  ThreadData.swift
//  FireBaseProject
//
//  Created by YOUNGSIC KIM on 2019-12-29.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import Foundation
import SwiftUI


struct CalendarDataType: Identifiable {
    var id: String
    var kcal : Float
    var date : String
    var level : String
    
}



func makeCalendarToday() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd HH:mm "
    return formatter.string(from: date)
}

func dateToString(dateString : String) -> Date{
    let dateString:String = dateString

    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

    let date:Date = dateFormatter.date(from: dateString)!
    return date
}

func levelToColor(level : String) -> String{
    if level == "0"{
        return "level0"
    }
    if level == "1"{
        return "level1"
    }
    if level == "2"{
        return "level2"
    }else{
        return "level3"
    }
}
