//
//  CommerceVIew.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/02.
//

import SwiftUI
import PopupView

struct CommerceVIew: View {
    @AppStorage("userEmail") var userEmail = ""
    @ObservedObject var datas = firebaseData
    @State var productName : String = ""
    @State var show : Bool = false
    
    @State var address : String = ""
    @State var phoneNumber : String = ""
    @State var name : String = ""
    @State var productNum : Int = 1
    
    @State var showBuy : Bool = false
    @State var buyProductName : String = ""
    @State var buyProductPrice : Int = 0
    @State var canBuy : Bool = false
    @State var cantBuy : Bool = false
    @State var errorMessage : String = ""
    @State var successMessage : String = ""
    @State var buySuccess : Bool = false
    
    @State var deviceToken : String = "eok-S689KEZwprWBOLJMD4:APA91bF3MnF1UUHkvGjINUDrS7ssM6uTRGc9Q2fy-Dr3NYiRTe4SfzKrI8iGH7cbiFrRdecfBb3pUHdtswNL-2MUeFdFbTmy0PPwI729X4lBhYbmyWR5l2EDldrprNpPITzGbr6iASOE"
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                SuccessAlertView(alert: $buySuccess, errorMassage: $successMessage)
                    .zIndex(2)
                if showBuy{
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.3))
                        .frame(width: 390, height: 900)
                        .zIndex(1)
                }
                ZStack{
                    VStack{
                        ZStack{
                            
                            BlurView(effect: .systemUltraThinMaterialLight)
                                .frame(width: 400, height: 100)
                            Text("CLAY SHOP")
                                .font(Font.custom(systemFont, size: 23))
                                .foregroundColor(Color.init("systemColor"))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.top,45)
                
                        }
                       
                        
                       
                    }
                    .position(x: geometry.size.width / 2, y: 50)
                    .zIndex(1)
                    
                    ScrollView{
                        VStack(spacing : 10){
                            Rectangle()
                                .frame(width: 180, height: 200)
                                .opacity(0)
                                .cornerRadius(15)
                            HStack{
                              
                                VStack{
                                    HStack{
                                        Rectangle()
                                            .frame(width: 2, height: 17)
                                            .foregroundColor(Color.init("systemColor"))
                                            .padding(.bottom, 1)
                                            .padding(.leading, 8)
                                        Text("사용 가능한 포인트")
                                            .font(Font.custom(systemFont, size: 17))
                                            .fontWeight(.bold)
                                        Spacer()
                                        HStack(spacing : 0){
                                            Image("금화")
                                               .resizable()
                                               .clipShape(Circle())
                                               .frame(width: 27, height: 33)
                                               
                                               
                                               .padding(.bottom, 4)
                                            Text("\(datas.dataToDisplay["archievePoint"]!)")
                                                .font(Font.custom(systemFont, size: 20))
                                                .fontWeight(.bold)
                                                .frame(height: 6, alignment: .bottom)
                                                .background(Color.init("systemColor").opacity(0.5))
                                                .padding(.top,10)
                                             Text("P")
                                                .font(Font.custom(systemFont, size: 20))
                                                .fontWeight(.bold)
                                                .padding(.bottom, 5)
                                        }
                                        
                                        .padding(.trailing, 12)
                                       
                                        
                                    }
                                    
                                   
                                   
                                }
                                Spacer()
                            }
                            .padding(.leading, 7)
                            
                            HStack(spacing : 15){
                                ProductView(productName: "콤부차(4개입)", productPrice: 12500, show : $show, delay: 0.1, showBuy: $showBuy, buyProductName: $buyProductName, buyProductPrice: $buyProductPrice)
                                
                                ProductView(productName: "티트리트 여우티(20개입)", productPrice: 13000, show : $show, delay: 0.2, showBuy: $showBuy, buyProductName: $buyProductName, buyProductPrice: $buyProductPrice)
                            }
                            HStack(spacing : 15){
                                ProductView(productName: "닭가슴살 스테이크(5개입)", productPrice: 6500, show : $show, delay: 0.3, showBuy: $showBuy, buyProductName: $buyProductName, buyProductPrice: $buyProductPrice)
                                ProductView(productName: "티젠 콤부차(10개입)", productPrice: 4000, show : $show, delay: 0.4, showBuy: $showBuy, buyProductName: $buyProductName, buyProductPrice: $buyProductPrice)
                            }
                            HStack(spacing : 15){
                                ProductView(productName: "컵누들(1개입)", productPrice: 1000, show : $show, delay: 0.5, showBuy: $showBuy, buyProductName: $buyProductName, buyProductPrice: $buyProductPrice)
                                Rectangle()
                                    .frame(width: 180, height: 180)
                                    .opacity(0)
                                    .cornerRadius(15)
                            }
                           
                            
                        }
                        
                    }
                    .position(x: geometry.size.width / 2, y:330 )
                }
                
              
            }
            .popup(isPresented: $showBuy, closeOnTap: false){
                ZStack{
                    
                    WrongResetPasswordErrorView(alert: $cantBuy, errorMassage: $errorMessage)
                        .zIndex(2)
                    VStack(spacing : 15){
                        HStack{
                            Text("상품 주문")
                                .font(Font.custom(systemFont, size: 20))
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                            Spacer()
                            Button(action: {
                                showBuy = false
                                canBuy = false
                                productNum = 1
                            }, label: {
                                Image(systemName: "multiply")
                                    .resizable()
                                    .foregroundColor(Color.init("systemColor"))
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .padding(.trailing, 20)
                            })
                            
                        }
                        if canBuy{
                            VStack(spacing : 20){
                                VStack(spacing: 5){
                                    Text("이름")
                                    TextField("", text: $name)
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom(systemFont, size: 15))
                                        .frame(width: 250, height: 30, alignment: .center)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.init("systemColor"), lineWidth: 1.5))
                                    
                                    }
                                    .padding(.top, 20)
                                VStack(spacing: 5){
                                    Text("전화번호")
                                    TextField("", text: $phoneNumber)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.numberPad)
                                        .font(Font.custom(systemFont, size: 15))
                                        .frame(width: 250, height: 30, alignment: .center)
                                        .overlay(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(Color.init("systemColor"), lineWidth: 1.5))
                                    
                                }
                                VStack(spacing: 5){
                                    Text("주소")
                                    TextField("", text: $address)
                                        .multilineTextAlignment(.center)
                                        .font(Font.custom(systemFont, size: 15))
                                        .frame(width: 250, height: 30, alignment: .center)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.init("systemColor"), lineWidth: 1.5))
                                    
                                }
                                .padding(.bottom, 20)
                                Button(action: {
                                    if name != "" && phoneNumber != "" && address != ""{
                                        datas.createBuy(email: userEmail, name: name, productName: buyProductName, price: String(buyProductPrice * productNum), productNum: String(productNum), address: address, phoneNumber: phoneNumber)
                                        sendMessageToDevice()
                                        productNum = 1
                                        showBuy = false
                                        successMessage = "주문이 완료되었습니다."
                                        buySuccess = true
                                        canBuy = false
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            buySuccess = false
                                        }
                                        datas.updateArchievePoint(email: userEmail, archievePoint: String(Int(datas.dataToDisplay["archievePoint"]!)! - buyProductPrice * productNum ))
                                        
                                    }else{
                                        errorMessage = "모든 칸을 기입해주세요!"
                                        cantBuy = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            cantBuy = false
                                        }
                                    }
                                    
                                }, label: {
                                    Text("주문하기")
                                        .fontWeight(.bold)
                                        .font(Font.custom(systemFont, size: 15))
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50, alignment: .center)
                                        .background(Color.init("systemColor"))
                                        .cornerRadius(60)
                                        .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                                })
                            }
                            .padding(.leading, 20)
                        }else{
                            Image(buyProductName)
                                    .resizable()
                                    .frame(width: 300, height: 280)
                                    .cornerRadius(15)
                       
                            Text(buyProductName)
                                .font(Font.custom(systemFont, size: 20))
                                .fontWeight(.bold)
                                 
                                
                            HStack(spacing : 0){
                                Text("\(buyProductPrice * productNum)")
                                    .font(Font.custom(systemFont, size: 20))
                                Text(" 원")
                                    .font(Font.custom(systemFont, size: 20))
                                    .fontWeight(.bold)
                            }
                            
                                
                            HStack{
                                Button(action: {
                                    if productNum > 1{
                                        productNum -= 1
                                    }
                                }, label: {
                                    Image(systemName: "arrowtriangle.left.fill")
                                        .foregroundColor(Color.init("systemColor"))
                                        .frame(width: 20, height: 20)
                                })
                                Text("\(productNum)")
                                    .font(Font.custom(systemFont, size: 17))
                                    .fontWeight(.bold)
                                Button(action: {
                                    productNum += 1
                                }, label: {
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .foregroundColor(Color.init("systemColor"))
                                        .frame(width: 20, height: 20)
                                })
                            }
                                    
                                    
                                
          
                            Button(action: {
                                if Int(datas.dataToDisplay["archievePoint"]!)! >= buyProductPrice * productNum{
                                    canBuy = true
                                }else{
                                    cantBuy = true
                                    errorMessage = "포인트가 부족합니다!"
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        cantBuy = false
                                    }
                                }
                                
                            }, label: {
                                Text("포인트로 구매하기")
                                    .fontWeight(.bold)
                                    .font(Font.custom(systemFont, size: 15))
                                    .foregroundColor(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .background(Color.init("systemColor"))
                                    .cornerRadius(60)
                                    .shadow(color: Color.black.opacity(0.3), radius: 6, y:3 )
                            })
                        }
              
                    }
                    .padding(10)
                    .padding(.bottom, 5)
                    .frame(width: 350, height: self.canBuy ? 400:550)
                    .background(Color.white)
                    .cornerRadius(30.0)
                }
                
               
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .top)
        .onAppear{
            show = true
            
        }
       
    }
    func sendMessageToDevice(){
        
        // Simple Logic
        // Using Firebase API to send Push Notification to another device using token
        // Without having server....
        
        // Converting That to URL Request Format....
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else{
            return
        }
        
        let json: [String: Any] = [
        
            "to": deviceToken,
            "notification": [
            
                "title": "구매 알림",
                "body": "\(name)님이 \(buyProductName)을(를) \(productNum)개 주문하였습니다."
            ],
            "data": [
            
                // Data to be Sent....
                // Dont pass empty or remove the block..
                "user_name": "iJustine"
            ]
        ]
        
        
        // Use Your Firebase Server Key !!!
        let serverKey = "AAAA4bpgKHs:APA91bGCA0_P70PYH05U7KJuQ-pTjs52srM0JU9We09dkB13jgyt6oW95RqCKp8kGmqMi5CQiPKXiU1JQ-sklsaRZFayEpJ3AjKyhTBXbkKDhHA8PWSEK7RzMdZv0jg_-5MtD_2LOZIj"
        
        // URL Request...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // COnverting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        // Setting COntent Type and Authoritzation...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // Authorization key will be Your Server Key...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        // Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            // Else Success
            // CLearing Fields..
            // Or Your Action when message sends...
            print("Success")
            
        }
        .resume()
    }
}

