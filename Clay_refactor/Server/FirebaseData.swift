//
//  Data.swift
//  FireBaseProject
//
//  Created by YOUNGSIC KIM on 2019-12-29.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import Firebase
import FirebaseFirestore
import Combine
/*
var email: String
var age : String = ""
var cmHeight: String = ""
var kgWeight : String = ""
var targetWeight = ""
var isTabMale : Bool = true
var isTabFemale : Bool = false
var nickName : String = ""
var selectedActive = 0
var date:String
 */

let dbCollection = Firestore.firestore().collection("UserData")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    var sender:String?
    @Published var data = [ThreadDataType]()
    @Published var calendarData = [CalendarDataType]()
    @Published var dataToDisplay : [String : String] = ["archieveRate" : "0", "targetArchieve" : "0", "userPoint" : "0", "Kcal" : "0","nickName" : "", "archievePoint" : ""]
    @Published var kcalToDisplay : [String : Float] = ["morningKcal" : 0, "launchKcal" : 0, "dinnerKcal" : 0, "snackKcal" : 0]
    @Published var completeList : [String : Bool] = ["completeMorning": false, "completeLaunch" : false, "completeDinner" : false]
    @Published var homeCountToDisPlay : [String : String] = ["homeCount" : "0"]
    @Published var userTimeToDisPlay : [String : String] = ["userMorningTime" : "0","userLaunchTime" : "0","userDinnerTime" : "0"]
    @Published var foodList : [[String]] = []
    @Published var snackFoodList : [[String]] = []
    @Published var dietKcal : Float = 0
    @Published var calendarToDisplay : [String : String] = ["level" : "0", "date" : ""]
    @Published var calendarKcalToDisplay : [String : Float] = ["kcal" : 0]
    init() {
        readData()
        
    }
    
    // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
    func createData(email: String,
                    age : String,
                    cmHeight: String,
                    kgWeight : String,
                    targetWeight : String,
                    isTabMale : String,
                    nickName : String,
                    totalKcal : String,
                    userPoint : String,
                    archieveRate : String,
                    targetArchieve : String,
                    homeCount : Int,
                    userMorningTime : String,
                    userLaunchTime : String,
                    userDinnerTime : String,
                    archievePoint : String
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).setData([      "id" : dbCollection.document().documentID,
                                                    "email" : email,
                                                    "age" :age,
                                                    "height":cmHeight,
                                                    "weight":kgWeight,
                                                    "targetWeight":targetWeight,
                                                    "gender" : isTabMale,
                                                    "nickName":nickName,
                                                    "userPoint" : userPoint,
                                                    "Kcal" : totalKcal,
                                                    "date": makeToday(),
                                                    "archieveRate" : archieveRate,
                                                    "targetArchieve" : targetArchieve,
                                                    "userMorningTime" : userMorningTime,
                                                    "userLaunchTime" : userLaunchTime,
                                                    "userDinnerTime" : userDinnerTime,
                                                    "homeCount" : homeCount,
                                                    "archievePoint" : archievePoint
                                             ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("create data success")
            }
        }
    }
    
    
    
    // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
    func readData() {
        
        dbCollection.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read data success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = ThreadDataType(id : dbCollection.document().documentID,
                                                 email: diff.document.get("email") as! String?,
                                                 age: diff.document.get("age") as! String?,
                                                 cmHeight: diff.document.get("height") as! String?,
                                                 kgWeight: diff.document.get("weight") as! String?,
                                                 targetWeight: diff.document.get("targetWeight") as! String?,
                                                 isTabMale: diff.document.get("gender") as! String?,
                                                 nickName: diff.document.get("nickName") as! String?,
                                                 date: diff.document.get("date") as! String?,
                                                 userPoint: diff.document.get("userPoint") as! String?,
                                                 totalKcal: diff.document.get("Kcal") as! String?,
                                                 archieveRate: diff.document.get("archieveRate") as! String?,
                                                 targetArchieve : diff.document.get("targetArchieve") as! String?,
                                                 archievePoint : diff.document.get("archievePoint") as! String?)
                    self.data.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.data = self.data.map { (eachData) -> ThreadDataType in
                        var data = eachData
                        if data.email == diff.document.documentID {
                            data.age = diff.document.get("age") as! String?
                            data.cmHeight = diff.document.get("height") as! String?
                            data.kgWeight = diff.document.get("weight") as! String?
                            data.targetWeight = diff.document.get("targetWeight") as! String?
                            data.isTabMale = diff.document.get("gender") as! String?
                            data.nickName = diff.document.get("nickName") as! String?
                            data.date = diff.document.get("date") as! String?
                            data.userPoint = diff.document.get("userPoint") as! String?
                            data.totalKcal = diff.document.get("Kcal") as! String?
                            data.archieveRate = diff.document.get("archieveRate") as! String?
                            data.targetArchieve = diff.document.get("targetArchieve") as! String?
                            data.archieveRate = diff.document.get("archieveRate") as! String?
                            return data
                            
                        }else {
                            
                            return eachData
                            
                        }
                    }
                }
            }
        }
    }
    
    //Reference link: https://firebase.google.com/docs/firestore/manage-data/delete-data
    func deleteData(datas: FirebaseData ,index: IndexSet) {
        let id = datas.data[index.first!].email
        dbCollection.document(id!).delete { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("delete data success")
            }
            datas.data.remove(atOffsets:index)
        }
    }
    

    func apiCall(email:String, data : String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
    Firestore.firestore().collection("UserData").document(email).addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.dataToDisplay[data] = document.get(data) as? String ?? ""
    } else {
        print("Document does not exist")
    }
   }
  }
   
    func updatePoint(
        email : String,
        archieveRate : String
        
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).updateData([
                                                                                    
            "archieveRate" : archieveRate             ])
    }
    
    func updateArchievePoint(
        email : String,
        archievePoint : String
        
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).updateData([
                                                                                    
            "archievePoint" : archievePoint             ])
    }
    
    
    
    func updateTargetArchieve(
        email : String,
        targetArchieve : String
        
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).updateData([
                                                                                    
            "targetArchieve" : targetArchieve             ])
    }
    func updateHomeCount(
        email : String,
        homeCount : String
        
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).updateData([
                                                                                    
            "homeCount" : homeCount             ])
    }
    
    func homeCountCall(email:String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
    Firestore.firestore().collection("UserData").document(email).addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.homeCountToDisPlay["homeCount"] = document.get("homeCount") as? String ?? ""
    } else {
        print("Document does not exist")
    }
   }
  }
    func calendarCall(email:String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        dbCollection.document(email).collection("Calendar").document(makeTodayDetail()).addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.calendarToDisplay["level"] = document.get("level") as? String ?? ""
    } else {
        print("Document does not exist")
    }
   }
  }
    func calendarkcalCall(email:String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        dbCollection.document(email).collection("Calendar").document(makeTodayDetail()).addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.calendarKcalToDisplay["kcal"] = document.get("kcal") as? Float ?? 0
    } else {
        print("Document does not exist")
    }
   }
  }
    func userTimeCall(email:String, data : String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
    Firestore.firestore().collection("UserData").document(email).addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.userTimeToDisPlay[data] = document.get(data) as? String ?? ""
    } else {
        print("Document does not exist")
    }
   }
  }
   
  
    
    
    
    func isCanGetPoint(
        email : String,
        userPoint : String
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).updateData([
                                                                                    
            "userPoint" : userPoint
                                                    ])
    }
    
    
    func createFoodList(
        email : String,
        foodName : String,
        serveSize : String,
        date : String = makeToday(),
        kcal : String
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").collection("foodList").document(foodName).setData([
                                                                                    
                                                    "id" : dbCollection.document().documentID,
                                                    "serveSize" : serveSize,
                                                    "kcal": kcal
                                                    ])
    }
    
    func createSnackFoodList(
        email : String,
        foodName : String,
        serveSize : String,
        date : String = makeToday(),
        kcal : String
       
                    )
    {
        
        // To create or overwrite a single document
        dbCollection.document(email).collection("diary").document(date + " Snack").collection("foodList").document(foodName).setData([
                                                                                    
                                                    "id" : dbCollection.document().documentID,
                                                    "serveSize" : serveSize,
                                                    "kcal": kcal
                                                    ])
    }

    func createDiary(
        email : String,
        image : String,
        diaryText : String,
        date : String = makeToday(),
        morningKcal : Float,
        launchKcal : Float,
        dinnerKcal : Float
       

                    )
    {
        
        // To create or overwrite a single document
        if isMorning(){
            dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").setData([
                                                                                        
                                                        "id" : dbCollection.document().documentID,
                                                        "image" : image,
                                                        "diaryText\(makeMealString())" : diaryText,
                                                        "date": makeToday(),
                                                        "morningKcal" : morningKcal,
                                                        "completeMorning" : true
                                                        
                                                        ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("create data success")
                }
            }
        }
        else if isLaunch(){
            dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").setData([
                                                                                        
                                                        "id" : dbCollection.document().documentID,
                                                        "image" : image,
                                                        "diaryText\(makeMealString())" : diaryText,
                                                        "date": makeToday(),
                                                        "launchKcal" : launchKcal,
                                                        "completeLaunch" : true
                                                        ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("create data success")
                }
            }
        }
        else if isDinner(){
            dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").setData([
                                                                                        
                                                        "id" : dbCollection.document().documentID,
                                                        "image" : image,
                                                        "diaryText\(makeMealString())" : diaryText,
                                                        "date": makeToday(),
                                                        "dinnerKcal" : dinnerKcal,
                                                        "completeDinner" : true
                                                        ]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("create data success")
                }
            }
        }
      
       
    }
    
    func createSnackDiary(
        email : String,
        image : String,
        diaryText : String,
        date : String = makeToday(),
        snackKcal : Float

                    )
    {
        
        // To create or overwrite a single document

    dbCollection.document(email).collection("diary").document(date + " Snack").setData([
                                                                                
                                                "id" : dbCollection.document().documentID,
                                                "image" : image,
                                                "diaryTextSnack" : diaryText,
                                                "date": makeToday(),
                                                "snackKcal" : snackKcal
                                              
                                                ])
        
    
    }
    
    
    
    func KcalCall(email:String, data : String, date : String = makeToday(), meal : String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
    dbCollection.document(email).collection("diary").document(date + " \(meal)").addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.kcalToDisplay[data] = document.get(data) as? Float ?? 0
    } else {
        print("Document does not exist")
    }
   }
  }
   
    
    
    
    func isCompleteCall(email:String, data : String, date : String = makeToday(), meal : String) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
    dbCollection.document(email).collection("diary").document(date + " \(meal)").addSnapshotListener{ (document, error) in
    if let document = document, document.exists {
        _ = document.data().map(String.init(describing:)) ?? "nil"
        self.completeList[data] = document.get(data) as? Bool ?? nil
    } else {
        print("Document does not exist")
    }
   }
  }
    
    
    func foodListCall(email:String,date : String = makeToday()) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").collection("foodList")
            .addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()["kcal"]!)")
                    if self.foodList.contains(["\(document.documentID)","\(document.data()["serveSize"]!)","\(document.data()["kcal"]!)"]){
                        
                    }else{
                        
                        self.dietKcal = self.dietKcal + Float("\(document.data()["kcal"]!)")!
                        self.foodList.append(["\(document.documentID)","\(document.data()["serveSize"]!)","\(document.data()["kcal"]!)"])
                        
                    }
                   
                }
            }
        }
   }
    
    func snackFoodListCall(email:String,date : String = makeToday()) {
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        dbCollection.document(email).collection("diary").document(date + " Snack").collection("foodList")
            .addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()["kcal"]!)")
                    if self.snackFoodList.contains(["\(document.documentID)","\(document.data()["serveSize"]!)","\(document.data()["kcal"]!)"]){
                        
                    }else{
                        
                        self.dietKcal = self.dietKcal + Float("\(document.data()["kcal"]!)")!
                        self.snackFoodList.append(["\(document.documentID)","\(document.data()["serveSize"]!)","\(document.data()["kcal"]!)"])
                        
                    }
                   
                }
            }
        }
   }
    
    func deleteFoodList(email : String, date : String = makeToday(), foodName : String) {
        dbCollection.document(email).collection("diary").document(date + " \(makeMealString())").collection("foodList").document(foodName).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func deleteSnackFoodList(email : String, date : String = makeToday(), foodName : String) {
        dbCollection.document(email).collection("diary").document(date + " Snack").collection("foodList").document(foodName).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func createBuy(email: String, name: String, productName:String, price : String, productNum : String, address : String, phoneNumber : String) {
        // To create or overwrite a single document
        Firestore.firestore().collection("cloudmessageDB").document().setData([
            "id" : dbCollection.document().documentID,
            "email":email,
            "name":name,
            "date":makeTodayDetail(),
            "price":price,
            "productName" : productName,
            "productNum" : productNum,
            "address" : address,
            "phoneNumber" : phoneNumber
        ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("create data success")
            }
        }
    }
    
    func updateCalnedar(email: String, kcal: Float, date:String, level : String) {
        // To create or overwrite a single document
        
        dbCollection.document(email).collection("Calendar").document(makeTodayDetail()).updateData([
            "id" : dbCollection.document().documentID,
            "email":email,
            "kcal":kcal,
            "date":makeTodayDetail(),
            "level" : level
           
        ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("create data success")
            }
        }
    }
    
    func createCalnedar(email: String, kcal: Float, date:String, level : String) {
        // To create or overwrite a single document
        dbCollection.document(email).collection("Calendar").document(makeTodayDetail()).setData([
            "id" : dbCollection.document().documentID,
            "email":email,
            "kcal":kcal,
            "date":makeTodayDetail(),
            "level" : level
           
        ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("create data success")
            }
        }
    }
    
    func readCalendarData(email : String) {
        dbCollection.document(email).collection("Calendar").addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read data success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = CalendarDataType(
                                                    id: diff.document.documentID,
                                                   kcal : diff.document.get("kcal") as! Float,
                                                   date : diff.document.get("date") as! String,
                                                   level:diff.document.get("level") as! String)
                    self.calendarData.append(msgData)
                }
                
                // Real time modify from server
                if (diff.type == .modified) {
                    self.calendarData = self.calendarData.map { (eachData) -> CalendarDataType in
                        var data = eachData
                        if data.id == diff.document.documentID {
                            data.kcal = diff.document.get("kcal") as! Float
                            data.date = diff.document.get("date") as! String
                            data.level = diff.document.get("level") as! String
                          
                            
                            return data
                        }else {
                            return eachData
                        }
                    }
                }
            }
        }
    }
  
}
