//
//  Clay_2App.swift
//  Clay 2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI
import Firebase

@main
struct Clay_newApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    var body: some Scene {
        
        WindowGroup {
            let viewModel = AppViewModel()
            Main()
                .environmentObject(viewModel)
        }
    }
}
