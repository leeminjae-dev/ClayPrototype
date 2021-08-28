//
//  MyList.swift
//  Clay2
//
//  Created by 이민재 on 2021/08/28.
//

import SwiftUI

struct MyList : View{
    init(){
        if #available(iOS 14.0, *){
    } else {
        UITableView.appearance().tableFooterView = UIView()
    
    }
        UITableView.appearance().tableFooterView = UIView()
    }
    var body: some View{
        List{
             Section(header: Text("헤더")){
                Text("hello")
                Text("hello")
                Text("hello")
                Text("hello")
            }
             .listRowInsets(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 10))
            
        }
        .listStyle(GroupedListStyle())
    }
}
struct MyList_Previews : PreviewProvider{
    static var previews: some View{
        MyList()
    }
}

