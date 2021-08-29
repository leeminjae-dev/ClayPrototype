//
//  Practice.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/29.
//

import Foundation
import SwiftUI

struct Practice: View {
    @State private var Id: String = ""
    @State private var password: String = ""
    var body: some View{
        VStack{
            TextField("ID", text : $Id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            SecureField("Password", text : $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}



struct Practice_Previews : PreviewProvider{
    static var previews: some View{
        Practice()
    }
}
