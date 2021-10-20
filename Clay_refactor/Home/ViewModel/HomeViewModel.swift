//
//  HomeViewModel.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI
import FirebaseStorage

let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

class HomeViewModel : ObservableObject{

    @Published var timeNow = ""
    
    @Published var userImageURL : String = ""
    
    @Published var morningTimeRemaining = 1
    @Published var launchTimeRemaining = 1
    @Published var dinnerTimeRemaining = 1
    
    @Published var isMorningTimeOver : Bool = false
    @Published var isLaunchTimeOver : Bool = false
    @Published var isDinnerTimeOver : Bool = false
    
    
    @Published var isTabDiet : Bool = false
    
    @AppStorage("userEmail") var userEmail = ""
    
    @Published var counter:Int = 0
    
    @Published var showingPopup : Bool = false
    @Published var showingTimePopup : Bool = false
    @Published var showingPointPopup : Bool = false
    @Published var showingFailPopup : Bool = false
    
    @Published var tasks: [TaskMetaData] = []
    @Published var currentDate: Date = Date()
    
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    
    func getTimeToSeconds() -> Int{
        let date = Date()
       let calender = Calendar.current
       let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

       let hour = components.hour
        let minute = components.minute
        let second = components.second

       return hour! * 60 * 60 + minute! * 60 + second!

    }
}
    
