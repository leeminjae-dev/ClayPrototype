//
//  GetBodyInfoView.swift
//  Clay_new
//
//  Created by 이민재 on 2021/09/03.
//

import SwiftUI

struct GetBodyInfoView: View {
    
    @State var bodyInfoCurrentPage : Int = 1
    @State var getBodyInfoTotalPage = 8
   
    var body: some View {
        if bodyInfoCurrentPage >  getBodyInfoTotalPage{
            MainSignUp()
        }else{
            BodyInfoPages(bodyInfoCurrentPage: $bodyInfoCurrentPage)
        }
    }
}

struct GetBodyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GetBodyInfoView()
    }
}
