//
//  DonateView.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/02.
//

import SwiftUI

struct DonateView: View {
    var body: some View {
        Image("service")
            .resizable()
            .frame(width: 380, height: 780)
            .position(x: 195, y: 290)
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
