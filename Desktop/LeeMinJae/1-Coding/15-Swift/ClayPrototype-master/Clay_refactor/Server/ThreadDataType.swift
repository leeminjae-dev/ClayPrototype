//
//  ThreadData.swift
//  FireBaseProject
//
//  Created by YOUNGSIC KIM on 2019-12-29.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import Foundation
import SwiftUI

struct ThreadDataType: Identifiable {
    var id: String?
    var email: String?
    var age : String?
    var cmHeight: String?
    var kgWeight : String?
    var targetWeight : String?
    var isTabMale : String?
    var nickName : String?
    var date:String?
    var userPoint : String?
    var totalKcal : String?
    var archieveRate : String?
    var targetArchieve : String?
    var archievePoint : String?
}


func makeToday() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MMM dd"
    return formatter.string(from: date)
}

func makeTodayDetail() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
}

