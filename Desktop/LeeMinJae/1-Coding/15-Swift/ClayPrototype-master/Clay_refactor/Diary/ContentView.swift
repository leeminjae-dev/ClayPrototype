//
//  ContentView.swift
//  Firebase_Storage_Test
//
//  Created by YOUNGSIC KIM on 2020-01-29.
//  Copyright © 2020 YOUNGSIC KIM. All rights reserved.
//
import SwiftUI
import FirebaseStorage
import Combine




struct ContentView: View {
    @State var shown = false
    @State var imageURL = ""
    @State var isLoading : Bool = false
    @AppStorage("userEmail") var userEmail = ""
    var body: some View {
        VStack {
            if imageURL != "" {
                FirebaseImageView(imageURL: imageURL)
            }
            
            Button(action: { self.shown.toggle() }) {
                Text("Upload Image").font(.title).bold()
            }.sheet(isPresented: $shown) {
                imagePicker(shown: self.$shown,imageURL: self.$imageURL, isLoading: $isLoading)
                }.padding(10).background(Color.purple).foregroundColor(Color.white).cornerRadius(20)
        }.onAppear(perform: loadImageFromFirebase).animation(.spring())
    }
    
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: FILE_NAME)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
    
   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
