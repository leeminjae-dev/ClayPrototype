//
//  Clay_refactorApp.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI


@main
struct Clay_refactorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(userData)
                .environmentObject(SignAppViewModel())
                
               
        }
        
    }
}
