//
//  Clay_refactorApp.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/05.
//

import SwiftUI
import FirebaseMessaging

import Firebase

@main
struct Clay_refactorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var userData = UserData()
    
    
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(SignAppViewModel())
                .environmentObject(userData)
                
               
        }
        
    }
}
//
//  AppDelegate.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/31.
//
