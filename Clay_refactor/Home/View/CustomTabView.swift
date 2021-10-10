//
//  CustomTabView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/16.
//

import SwiftUI
import FirebaseStorage

struct CustomTabView: View {
    @State var selectedTab = "house"
    @State var isTabDiet = false
    @State var isTabSnackDiet = false
    @State var userImageURL : String = ""
    var body: some View {
        if isTabDiet{
            
            DiaryView(isTabDiet: $isTabDiet)
                
               
        }
        else if isTabSnackDiet{
            SnackDiaryView(isTabSnackDiet : $isTabSnackDiet)
        }
        else{
            ZStack(alignment: .bottom){
           
                if selectedTab == "house"{
                    
                    HomeView(isTabDiet: $isTabDiet, isTabSnackDiet: $isTabSnackDiet, userImageURL: $userImageURL)
                }
                if selectedTab == "heart"{
                    DonateView()
                        
                }
                if selectedTab == "cart"{
                    CommerceVIew()
                }
                if selectedTab == "person.circle"{
                    VStack{
                       MyPageView(userImageURL: $userImageURL)
                            Spacer()
                    }
                   
                    
                }
                    
                
                
                CustomTabBar(selectedTab: $selectedTab)
                    
                   
            } .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                .onAppear{
                    loadImageFromUserImageFirebase()
                }
            
        }
        
        
    }
    func loadImageFromUserImageFirebase() {
        let storage = Storage.storage().reference(withPath: "Diary/\(makeEmailString())/ProfileImage.jpg")
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.userImageURL = "\(url!)"
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
