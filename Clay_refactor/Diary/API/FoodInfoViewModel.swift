//
//  RandomUserViewModel.swift
//  RandomUserApi
//
//  Created by Jeff Jeong on 2021/03/10.
//

import Foundation
import Combine
import Alamofire

class FoodInfoViewModel: ObservableObject {
    
    //MARK: Properties
    var subscription = Set<AnyCancellable>()
    
    @Published var FoodInfo = [Items]()
    @Published var foodName : String = ""
    @Published var baseUrl : String = "http://apis.data.go.kr/1470000/FoodNtrIrdntInfoService/getFoodNtrItdntList?serviceKey=6IND7sjQK373/SKpclxTtcHIivzFEB9mrEx8eaTGXchSQEN9jS1LNprfx6ByBEtQYRAvBdISdhtU8PjHYd0TZA==&type=json&pageNo=1&numOfRows=40&desc_kor="
    
    init() {
        
        print(#fileID, #function, #line, "")
        
    }
    
    func fetchFoodInfo(searchFoodName : String){
        print(#fileID, #function, #line, "")
        AF.request((baseUrl+searchFoodName).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get,encoding: URLEncoding.queryString)
            .publishDecodable(type: FoodInfoResponse.self)
            .compactMap{$0.value }
            .map{ $0.jsonBody.items}
            .sink(receiveCompletion: { completion in
                print("데이터스트림 완료 ")
            }, receiveValue: { receivedValue in
                print("받은 값 : \(receivedValue.count)")
                self.FoodInfo = receivedValue
            }).store(in: &subscription)
    }
    
}
