//
//  HomeProfileView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/15.
//

import SwiftUI
import Kingfisher

struct HomeProfileView: View {
    
    @ObservedObject var datas = firebaseData
    @StateObject var homeViewModel = HomeViewModel()
    @Binding var userImageURL : String
 
    
    var body: some View {
        HStack(spacing: 5){
            ZStack{
                if userImageURL != ""{

                    KFImage(URL(string: userImageURL))
                        .resizable()
                        .frame(width : 65, height : 65)
                        .clipShape(Circle())
                        .padding(.trailing, 12)
                        .padding(.top, 7)


                }else{
                    ZStack{
                        Image(systemName : "person")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.black)
                            
                            .multilineTextAlignment(.center)
                            .padding(.trailing, 13)
    
                        Circle()
                            .foregroundColor(Color.gray.opacity(0.7))
                            .frame(width : 65, height : 65)
                            .padding(.trailing, 12)
                        
                    }
                  
                }
                
                
            }
           
            HStack(spacing : 5){
                Text("\(datas.dataToDisplay["nickName"]!)님은 오늘")
                    .font(Font.custom(systemFont, size: 13))
                Text("\(Float(datas.dataToDisplay["Kcal"]!)! - datas.kcalToDisplay["morningKcal"]! - datas.kcalToDisplay["launchKcal"]! - datas.kcalToDisplay["dinnerKcal"]! - datas.kcalToDisplay["snackKcal"]!, specifier: "%.0f")Kcal")
                    .font(Font.custom(systemFont, size: 13))
                    .fontWeight(.bold)
                    .frame(height: 6, alignment: .bottom)
                    .background(Color.init("systemColor").opacity(0.5))
                    .padding(.top,10)
                Text("만큼 먹을 수 있어요")
                    .font(Font.custom(systemFont, size: 13))
            }
            .padding(.top, 5)

        }
        
    }
       
}

struct HomeProfileView_Previews: PreviewProvider {
    

    static var previews: some View {
        HomeProfileView(userImageURL: .constant("John"))
    }
}
