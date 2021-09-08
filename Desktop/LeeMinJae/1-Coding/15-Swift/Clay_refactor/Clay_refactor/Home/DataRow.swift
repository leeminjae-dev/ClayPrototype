//
//  DataRow.swift
//  FireBaseProject
//
//  Created by YOUNGSIC KIM on 2019-12-31.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import SwiftUI

struct DataRow: View {
    
    @State var data: ThreadDataType
    
    var body: some View {
        VStack{
            Text("포인트")
            Text(data.userPoint!)
        }
    }
    
}

