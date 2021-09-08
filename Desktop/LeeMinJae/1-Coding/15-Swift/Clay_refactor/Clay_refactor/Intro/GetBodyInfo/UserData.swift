//
//  UserData.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI

class UserData: ObservableObject {
    
    @Published var age : String = ""
    @Published var cmHeight: String = ""
    @Published var kgWeight : String = ""
    @Published var targetWeight :String = ""
    @Published var isTabMale : Bool = false
    @Published var isTabFemale : Bool = true
    @Published var nickName : String = ""
    @Published var selectActive : Int = 0
    @Published var totalKcal : String = ""
    @Published var userPoint : String = "0"
    @Published var email : String = ""
    
}
