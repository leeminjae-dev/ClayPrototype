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
    @Published var totalKcal : String = "0"
    @Published var userPoint : String = "0"
    @Published var email : String = ""

    @Published var friendList : [String] = []
    @Published var foodList : [[String]] = []
    
    @Published var targetArchieve : String = "1"
    @Published var archieveRate : String = "0"
    @Published var foodStruct : [nutrition] = []
    
    @Published var userMorningTime : Int = 8
    @Published var userLaunchTime : Int = 12
    @Published var userDinnerTime : Int = 18
    
    @Published var dinnerTime : Bool = false
    @Published var offDinnerTime : Bool = false
    @Published var dinnerTimeRemaining : Int = 0
    
    @Published var archievePoint : String = ""
    @Published var userImageURL : String = ""
}


public struct nutrition{
    var foodName : String
    var kcal : String
    var serve : String
}
