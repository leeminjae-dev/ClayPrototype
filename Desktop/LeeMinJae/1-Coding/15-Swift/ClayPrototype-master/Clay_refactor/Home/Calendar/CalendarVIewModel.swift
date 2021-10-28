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
    @Published var dinnerImageURL : String = ""
    
    func loadImageFromFirebase(path : String, meal : String) {
        let storage = Storage.storage().reference(withPath: path)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            if meal == "morning"{
                self.morningImageURL = "\(url!)"
            }
            else if meal == "launch"{
                self.launchImageURL = "\(url!)"
            }
            else if meal == "dinner"{
                self.dinnerImageURL = "\(url!)"
            }
           
        }
       
    }
    
    
}
