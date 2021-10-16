//
//  ChevronButton.swift
//  Clay_refactor
//
//  Created by 이민재 on 2021/10/16.
//

import SwiftUI

struct ChevronButton: View {
    @EnvironmentObject var userData : UserData
    
    @Binding var bodyInfoCurrentPage : Int
    @Binding var showPopup : Bool
    @Binding var activate : Bool
    var body: some View {
        HStack{
            Button(action: {
                    withAnimation(.easeInOut){
                        if self.bodyInfoCurrentPage != 1{
                            
                            bodyInfoCurrentPage-=1
                        }
                        
                    }
                
            }, label: {
                if bodyInfoCurrentPage < 5{
                    if showPopup{
                        
                    }else{
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size : 30))
                            .foregroundColor(Color.white)
                            .font(Font.custom(systemFont, size: 20))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                        
                    }
                   
                        
                }else{
                   
                }
               
                
            })
            PageControl(maxPages: 5, currentPage: bodyInfoCurrentPage-1)
            
            Button(action: {
                    withAnimation(.easeInOut){
                        if bodyInfoCurrentPage ==  1{
                            
                            bodyInfoCurrentPage += 1
                            
                        }
                        else if bodyInfoCurrentPage ==  2{
                            if userData.nickName != "" && userData.age != "" && userData.cmHeight != ""{
                                
                                    bodyInfoCurrentPage += 1
                            
                            }
                            
                        }
                        else if bodyInfoCurrentPage ==  3{
                            if userData.kgWeight != "" && userData.targetWeight != "" {
                                
                                    bodyInfoCurrentPage += 1
                            
                            }
                            
                        }
                        else if bodyInfoCurrentPage ==  4{
                            userData.totalKcal = cal(weight: Double(userData.kgWeight)!, height: Double(userData.cmHeight)!, age: Double(userData.age)!, gender: userData.isTabMale, selectAtivate: userData.selectActive, targetWeight: Double(userData.targetWeight)!)
                            showPopup = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showPopup = false
                                if Double(userData.totalKcal)! > 3000 || Double(userData.totalKcal)!  < 700{
                                    bodyInfoCurrentPage += 2
                                }else{
                                    bodyInfoCurrentPage += 1
                                }
                                
                            }
                           
                        }
                        else if bodyInfoCurrentPage == 5{
                           
                            activate.toggle()
                        }
                        
                        
                    }
                
            }, label: {
                if bodyInfoCurrentPage < 5{
                    if bodyInfoCurrentPage ==  1{
                       
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor"))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                       
                    }
                    
                    else if bodyInfoCurrentPage ==  2{
                        if userData.nickName != "" && userData.age != "" && userData.cmHeight != ""{
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor"))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                       
                        }else{
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor").opacity(0.3))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                        }
                        
                    }
                    else if bodyInfoCurrentPage ==  3{
                        if userData.kgWeight != "" && userData.targetWeight != "" {
                            
                            if showPopup{
                                
                            }else{
                                Image(systemName: "chevron.right")
                                    .font(.system(size : 30))
                                    .foregroundColor(Color.white)
                                    .font(Font.custom(systemFont, size: 20))
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .background(Color.init("systemColor"))
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                            }
                           
                       
                        }
                        else{
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor").opacity(0.3))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                        }
                        
                    }
                    else if bodyInfoCurrentPage ==  3{
                        if userData.kgWeight != "" && userData.targetWeight != "" {
                            
                            if showPopup{
                                
                            }else{
                                Image(systemName: "chevron.right")
                                    .font(.system(size : 30))
                                    .foregroundColor(Color.white)
                                    .font(Font.custom(systemFont, size: 20))
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .background(Color.init("systemColor"))
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                            }
                           
                       
                        }
                        else{
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor").opacity(0.3))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                        }
                        
                    }
                    else if bodyInfoCurrentPage ==  4{
                        if userData.kgWeight != "" && userData.targetWeight != "" {
                            
                            if showPopup{
                                
                            }else{
                                Image(systemName: "chevron.right")
                                    .font(.system(size : 30))
                                    .foregroundColor(Color.white)
                                    .font(Font.custom(systemFont, size: 20))
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .background(Color.init("systemColor"))
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                            }
                           
                       
                        }
                        else{
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size : 30))
                                .foregroundColor(Color.white)
                                .font(Font.custom(systemFont, size: 20))
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(Color.init("systemColor").opacity(0.3))
                                .clipShape(Circle())
                                .shadow(radius: 1)
                            
                        }
                        
                    }
                    else if bodyInfoCurrentPage == 5{
                        
                    }else{
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size : 30))
                            .foregroundColor(Color.white)
                            .font(Font.custom(systemFont, size: 20))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.init("systemColor"))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                   
                }
                    
                         
                
            })
            
            
        }
    }
}

struct ChevronButton_Previews: PreviewProvider {
    static var previews: some View {
        ChevronButton(bodyInfoCurrentPage: .constant(1), showPopup: .constant(false), activate: .constant(false))
    }
}
