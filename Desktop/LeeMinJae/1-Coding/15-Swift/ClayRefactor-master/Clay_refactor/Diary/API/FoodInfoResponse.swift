//
//  RandomUser+ResponseData.swift
//  RandomUserApi
//
//  Created by Jeff Jeong on 2021/03/10.
//

import Foundation


struct Items: Codable, Identifiable, CustomStringConvertible {
    var id = UUID()
    var DESC_KOR : String
    var SERVING_WT : String
    var kcal : String
    var carbohydrate : String
    var protein : String
    var fat : String
    var sugars : String
    var salt : String
    var cholesterol : String
    var saturatedFat : String
    var transFat : String
    var ANIMAL_PLANT :String
    
    private enum CodingKeys: String, CodingKey {
        case DESC_KOR = "DESC_KOR"
        case SERVING_WT = "SERVING_WT"
        case kcal = "NUTR_CONT1"
        case carbohydrate = "NUTR_CONT2"
        case protein = "NUTR_CONT3"
        case fat = "NUTR_CONT4"
        case sugars = "NUTR_CONT5"
        case salt = "NUTR_CONT6"
        case cholesterol = "NUTR_CONT7"
        case saturatedFat = "NUTR_CONT8"
        case transFat = "NUTR_CONT9"
        case ANIMAL_PLANT = "ANIMAL_PLANT"
    }
    var description: String {
        if ANIMAL_PLANT != ""{
            return "\(DESC_KOR)(\(ANIMAL_PLANT))"
        }else{
            return "\(DESC_KOR)"
        }
        
    }
    var displayKcal: String {
        return "\(kcal)"
    }
    var displayServe : String{
        return "\(SERVING_WT)g"
    }
    var nutrition: [String] {
        return [DESC_KOR,SERVING_WT,kcal,carbohydrate,protein,fat,sugars,cholesterol,saturatedFat,transFat,ANIMAL_PLANT]
    }
    
}


struct JsonBody: Codable {
    
    var items : [Items]
    
    var description: String {
        return "items : \(items.count)"
    }

}

struct FoodInfoResponse: Codable, CustomStringConvertible {
    var jsonBody: JsonBody
   
    private enum CodingKeys: String, CodingKey {
        case jsonBody = "body"
    }
    var description: String {
        return "body: \(jsonBody)"
    }
}
