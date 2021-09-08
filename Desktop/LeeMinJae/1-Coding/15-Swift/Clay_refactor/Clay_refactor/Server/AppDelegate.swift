//
//  AppDelegate.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/31.
//
import UIKit
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import Firebase


class AppDelegate: UIResponder, UIApplicationDelegate{
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        KakaoSDKCommon.initSDK(appKey: "dd20758255d8a0177bf6d3842c219f9e")
        FirebaseApp.configure()

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           if (AuthApi.isKakaoTalkLoginUrl(url)) {
               return AuthController.handleOpenUrl(url: url, options: options)
           }
           
           return false
       }

}



