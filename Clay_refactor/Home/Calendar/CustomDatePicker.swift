//
//  CustomDatePicker.swift
//  ElegantTaskApp (iOS)
//
//  Created by Balaji on 28/09/21.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @ObservedObject var datas = firebaseData
    @AppStorage("userEmail") var userEmail = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    @State var currentDay: Int = 0
    @Binding var tasks: [TaskMetaData]
    var body: some View {
        
        ScrollView{
            if #available(iOS 15, *){
                VStack(spacing: 10){
 
                    // Days...
                    let days: [String] = ["일","월","화","수","목","금","토"]
                    
                    HStack(spacing: 20){
                        Button {
                            withAnimation{
                                currentMonth -= 1
                                
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.init("darkGreen"))
                                .font(.title2)
                        }
                        
                        HStack( spacing: 5) {
                            
                            Text("\(extraDate()[0])년")
                                .font(Font.custom(systemFont, size: 23))
                                .fontWeight(.bold)
                            
                            Text("\(extraDate()[2])월")
                                .font(Font.custom(systemFont, size: 23))
                                .fontWeight(.bold)
                        }
                        
                       
                        
                      

                        Button {
                            
                            withAnimation{
                                currentMonth += 1
                            }
                            
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.init("darkGreen"))
                                .font(.title2)
                        }
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal)
                    // Day View...
                    
                    HStack(spacing: 0){
                        ForEach(days,id: \.self){day in
                            
                            Text(day)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundColor(Color.gray)
                        .opacity(0.1)
                    // Dates....
                    // Lazy Grid..
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: columns,spacing: 15) {
                        
                        ForEach(extractDate()){value in
                            
                            CardView(value: value)
                                .background(
                                
                                    Circle()
                                        .stroke()
                                        .fill(Color.red)
                                        .padding(.horizontal,8)
                                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                        .opacity(0)
                                    
                                )
                                .onTapGesture {
                                    currentDate = value.date
                                }
                        }
                    }
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundColor(Color.gray)
                        .opacity(0.1)
                    VStack(spacing: 3){
                        HStack{
                           
                            HStack(spacing : 15){
                
                                HStack{
                                    Circle()
                                        .fill(Color.init("level1"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 1회")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                                HStack{
                                    Circle()
                                        .fill(Color.init("level2"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 2회")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                                HStack{
                                    Circle()
                                        .fill(Color.init("level3"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 3회 모두 완료")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                            }
                        }
                        
                        
                        Text("정보")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.vertical,10)
                            .padding(.top, 20)
                        
                        if let task = tasks.first(where: { task in
                            return isSameDay(date1: task.taskDate, date2: currentDate)
                        }){
                            
                            ForEach(task.task){task in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    // For Custom Timing...
                                    Text("섭취한 칼로리")
                                    
                                    Text("\(task.title)")
                                        .font(.title2.bold())
                                }
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .background(
                                
                                    Color.init("systemColor")
                                        .opacity(0.5)
                                        .cornerRadius(10)
                                )
                            }
                        }
                        else{
                            
                            Text("정보가 없습니다")
                        }
                    }
                    .padding(.horizontal, 5)
                    
                   
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: currentMonth) { newValue in
                    
                    // updating Month...
                    currentDate = getCurrentMonth()
                }
                
            }else{
                VStack(spacing: 10){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 12, height: 18)
                                .foregroundColor(Color.init("systemColor"))
                            Text("Back")
                                .foregroundColor(Color.init("systemColor"))
                            Spacer()
                        }
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                    })
                  
                   
                    // Days...
                    let days: [String] = ["일","월","화","수","목","금","토"]
                    
                    HStack(spacing: 20){
                        Button {
                            withAnimation{
                                currentMonth -= 1
                                
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.init("darkGreen"))
                                .font(.title2)
                        }
                        
                        HStack( spacing: 5) {
                            
                            Text("\(extraDate()[0])년")
                                .font(Font.custom(systemFont, size: 23))
                                .fontWeight(.bold)
                            
                            Text("\(extraDate()[2])월")
                                .font(Font.custom(systemFont, size: 23))
                                .fontWeight(.bold)
                        }
                        
                       
                        
                      

                        Button {
                            
                            withAnimation{
                                currentMonth += 1
                            }
                            
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.init("darkGreen"))
                                .font(.title2)
                        }
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal)
                    // Day View...
                    
                    HStack(spacing: 0){
                        ForEach(days,id: \.self){day in
                            
                            Text(day)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundColor(Color.gray)
                        .opacity(0.1)
                    // Dates....
                    // Lazy Grid..
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: columns,spacing: 15) {
                        
                        ForEach(extractDate()){value in
                            
                            CardView(value: value)
                                .background(
                                
                                    Circle()
                                        .stroke()
                                        .fill(Color.red)
                                        .padding(.horizontal,8)
                                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                        .opacity(0)
                                    
                                )
                                .onTapGesture {
                                    currentDate = value.date
                                }
                        }
                    }
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundColor(Color.gray)
                        .opacity(0.1)
                    VStack(spacing: 3){
                        HStack{
                           
                            HStack(spacing : 15){
                
                                HStack{
                                    Circle()
                                        .fill(Color.init("level1"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 1회")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                                HStack{
                                    Circle()
                                        .fill(Color.init("level2"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 2회")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                                HStack{
                                    Circle()
                                        .fill(Color.init("level3"))
                                        .frame(width: 8,height: 8)
                                    Text("하루 달성 3회 모두 완료")
                                        .font(Font.custom(systemFont, size: 10))
                                }
                            }
                        }
                        
                        
                        Text("정보")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.vertical,10)
                            .padding(.top, 20)
                        
                        if let task = tasks.first(where: { task in
                            return isSameDay(date1: task.taskDate, date2: currentDate)
                        }){
                            
                            ForEach(task.task){task in
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    // For Custom Timing...
                                    Text("섭취한 칼로리")
                                    
                                    Text("\(task.title)")
                                        .font(.title2.bold())
                                }
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .background(
                                
                                    Color.init("systemColor")
                                        .opacity(0.5)
                                        .cornerRadius(10)
                                )
                            }
                        }
                        else{
                            
                            Text("정보가 없습니다")
                        }
                    }
                    .padding(.horizontal, 5)
                    .navigationBarItems(trailing:
                        Menu {
                           Button(action: {
                              //some action
                           }) {
                              //some label
                           }
                           Button(action: {
                              //some action
                           }) {
                              Text("ㅇㅇ")
                           }
                        }
                        label: {
                           //some label
                        }
                     )
                }
                .padding()
                .onChange(of: currentMonth) { newValue in
                    
                    // updating Month...
                    currentDate = getCurrentMonth()
                }
                .navigationBarHidden(true)
            }
           
        }
      
        .onAppear(){
            currentDate = getCurrentMonth()
            datas.readCalendarData(email: userEmail)
            for data in datas.calendarData{
                tasks.append(TaskMetaData(task: [

                    Task(title: "\(data.kcal) kcal")

                ], taskDate: dateToString(dateString: data.date), taskColor:levelToColor(level:data.level) ))
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        
        VStack{
            
            if value.day != -1{
                
                if let task = tasks.first(where: { task in
                    
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    ZStack{
                        if task.taskColor == "level1"{
                            Image("level1Image")
                                .resizable()
                                .frame(width: 32,height: 32)
                                .zIndex(2)
                                
                        }
                        if task.taskColor == "level2"{
                            Image("level2Image")
                                .resizable()
                                .frame(width: 32,height: 32)
                                .zIndex(2)
                                
                        }
                        if task.taskColor == "level3"{
                            Image("level3Image")
                                .resizable()
                                .frame(width: 32,height: 32)
                                .zIndex(2)
                                
                        }
                        Circle()
                            .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? Color.init(task.taskColor) : Color.init(task.taskColor))
                            .frame(width: 43,height: 43)
                            .shadow(color: isSameDay(date1: value.date, date2: currentDate) ? .black.opacity(0.5) : .white ,radius: 2, y: 3)
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? Color.black: .black.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .zIndex(1)
                       
                            
                    }
                    .padding(.bottom, 80)
                   
                }
                else{
                    ZStack{
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?  Color.black: .black.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .zIndex(1)
                        Circle()
                            .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?  Color.init("calendarTab"): Color.init("calendarNonTab"))
                            .frame(width: 43,height: 43)
                            .shadow(color: isSameDay(date1: value.date, date2: currentDate) ? .black.opacity(0.5) : .white ,radius: 2, y: 2)
                            
                    }
                   
                    
                    Spacer()
                }
            }
        }
        
        .padding(.vertical,9)
        .frame(width: 390,height: 60,alignment: .top)
    }
    
    // checking dates...
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year And Month for display...
    func extraDate()->[String]{
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate) 
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month], "\(month)"]
    }
    
    func getCurrentMonth()->Date{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date....
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
                
        return currentMonth
    }
    
    
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        // Getting Current Month Date....
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extending Date to get Current Month Dates...
extension Date{
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        // getting start Date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date...
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
