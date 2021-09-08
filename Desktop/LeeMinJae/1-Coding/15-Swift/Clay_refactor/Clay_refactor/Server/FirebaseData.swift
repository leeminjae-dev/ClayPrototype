//
//  Data.swift
//  FireBaseProject
//
//  Created by YOUNGSIC KIM on 2019-12-29.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import Firebase
import FirebaseFirestore
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
    
    @Published var data = [ThreadDataType]()
    
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
                    userPoint : String
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
                                                    "date": makeToday()]) { (err) in
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
                                                 totalKcal: diff.document.get("Kcal") as! String?)
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
    
    // Reference link: https://firebase.google.com/docs/firestore/manage-data/add-data
    func updateData(id: String, txt: String) {
        dbCollection.document(id).updateData(["content":txt]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("update data success")
            }
        }
    }
    
    
    
   
}
