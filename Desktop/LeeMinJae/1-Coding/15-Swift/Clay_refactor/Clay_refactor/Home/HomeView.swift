//
//  Main.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/09/07.
//

import SwiftUI
import Firebase
import FirebaseFirestore



struct HomeView: View {
    
    @EnvironmentObject var userData : UserData
    @EnvironmentObject var viewModel : SignAppViewModel
    @ObservedObject var datas = firebaseData
    
    @AppStorage("userEmail") var userEmail = ""
 
    
    var body: some View {
        
        VStack{
            HStack(spacing: 20){
                ForEach(datas.data){ data in
                    if data.email == userEmail{
                        Text("포인트 : \(data.userPoint!)")
                    }
                }
                
                ForEach(datas.data){ data in
                    if data.email == userEmail{
                        Text("칼로리 : \(data.totalKcal!)")
                    }
                }
            }
            .padding()

            LogoutBtn()
        }
        
        
    }

}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
