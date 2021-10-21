//
//  SwiftUIView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/21.
//

import SwiftUI
import FirebaseStorage

class CalendarViewModel : ObservableObject{
   
    @Published var morningImageURL : String = ""
    @Published var launchImageURL : String = ""
    
    func loadMorningImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: "Diary/\(makeEmailString())/2021 Oct 13/Breakfast.jpg")
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.morningImageURL = "\(url!)"
        }
       
    }
    
    func loadLaunchImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: "Diary/\(makeEmailString())/2021 Oct 13/Launch.jpg")
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.launchImageURL = "\(url!)"
        }
    }
}
