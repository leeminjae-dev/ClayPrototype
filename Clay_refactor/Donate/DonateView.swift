//
//  DonateView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/02.
//

import SwiftUI

struct DonateView: View {
    var body: some View {
        GeometryReader{ geometry in
            if #available(iOS 15,*){
                
                Image("service")
                    .resizable()
                    .frame(width: 400, height: 1000)
                    .position(x: 195, y: geometry.size.height/2.5)
        
            }
            
            else{
                
                Image("service")
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .position(x: 195, y: geometry.size.height/2)
                    
                
            }
            
        }
       
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
