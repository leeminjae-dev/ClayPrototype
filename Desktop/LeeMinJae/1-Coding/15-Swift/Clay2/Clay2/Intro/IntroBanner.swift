//
//  FollowYoutube.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/30.
//

import Foundation
import SwiftUI

struct IntroBanner: View {
    
    @State private var selectedTab : Trip = trips[0]
    
    
    var body: some View{
        
            GeometryReader{proxy in
                //let frame = proxy.frame(in: .global)
                    VStack{
                        VStack{
                            Text("클레이와 함께 도전하기")
                                .font(Font.custom(systemFont, size: 18))
                                .foregroundColor(Color.gray)
                                .padding(.trailing, 200)
                                .padding(.top, 40)
                                
                            TabView(selection : $selectedTab){
                                ForEach(trips){trip in
                                    Image(trip.image)
                                        .resizable()
                                        .frame(width: 400, height: 400, alignment: .center)
                                        .tag(trip)
                                }
                                
                            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(width: 400, height: 400, alignment: .center)
        
                            PageControl(maxPages: trips.count, currentPage: getIndex())
                        }
                        .padding(.bottom, 20 )
                        LogInBtn()
                    }
                        .padding(.bottom, 150)      
                
            }
        
            
    }
    func getIndex()->Int{
        
        let index = trips.firstIndex { (trip) -> Bool in
            return selectedTab.id == trip.id
            
        } ?? 0
        return index
   
    }

}



private var trips = [
    
    Trip(image: "IntroBanner1", title: "banner1"),
    Trip(image: "IntroBanner2", title: "banner2"),
    Trip(image: "IntroBanner3", title: "banner3"),
]

private struct Trip : Identifiable, Hashable{
    
    var id = UUID().uuidString
    var image : String
    var title : String
}


struct IntroBanner_Previews : PreviewProvider{
    static var previews: some View{
        IntroBanner()
    }
}
