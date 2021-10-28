//
//  CustomDatePicker.swift
//  ElegantTaskApp (iOS)
//
//  Created by Balaji on 28/09/21.
//

import SwiftUI
import FirebaseStorage

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @ObservedObject var datas = firebaseData
    @StateObject var calendarViewModel = CalendarViewModel()
    
    @AppStorage("userEmail") var userEmail = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Month update on arrow button clicks...
    
    @State var currentMonth: Int = 0
    @State var currentDay: Int = 0
    @State var isTabDate : Bool = false
    @State var isLoading : Bool = false
    @State var isLoadingEnd : Bool = false
    @State var show : Bool = false
    @State var index : Int = 1
    
    @State var morningCardOffset : CGFloat = 0
    @State var launchCardOffset : CGFloat = 0
    @State var dinnerCardOffset : CGFloat = 0
    
    @State var isTabLoading = false
    
    @Binding var tasks: [TaskMetaData]
    
    init(currentDate: Binding<Date>,tasks: Binding<[TaskMetaData]> ) {
           UINavigationBar.appearance().backgroundColor = .clear
        _currentDate = currentDate
        _tasks = tasks
       }
    
    var body: some View {
      
        ZStack{
           
            ZStack{
                if isLoading{
                    withAnimation(.spring()){
                        CalendarLoader()
                            .zIndex(isLoading ? 3 : 0)
                            .transition(.scale)
                            .animation(.easeOut.delay(1))
                            
                            
                      
                    }
                    
                }
            
                VStack{
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
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Breakfast.jpg", meal : "morning")
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Launch.jpg", meal : "launch")
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Dinner.jpg", meal : "dinner")
                                            
                                            datas.calendarMorningFoodList.removeAll()
                                            datas.calendarLaunchFoodList.removeAll()
                                            datas.calendarDinnerFoodList.removeAll()
                                            
                                            datas.calendarMorningFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Breakfast")
                                            datas.calendarLaunchFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Launch")
                                            datas.calendarDinnerFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Dinner")
                                            
                                            index = 1
                                            
                                            isTabDate = true
                                            
                                            isLoading = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                                                isLoading = false

                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                withAnimation(.spring()){
                                                    isLoadingEnd = true
                                                }
                                            }
                                            
                                           
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
                                .padding(.top, 20)
                               
                              
                            }
                            .padding(.horizontal, 5)
                            
                           
                        }
                        
                        .padding()
                        .padding(.top, 120)
                        .padding(.bottom, isLoadingEnd ? 0 : 155)
                        .background(Color.white)
                        .cornerRadius(20)
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
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Breakfast.jpg", meal : "morning")
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Launch.jpg", meal : "launch")
                                            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Dinner.jpg", meal : "dinner")
                                            
                                            datas.calendarMorningFoodList.removeAll()
                                            datas.calendarLaunchFoodList.removeAll()
                                            datas.calendarDinnerFoodList.removeAll()
                                            
                                            datas.calendarMorningFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Breakfast")
                                            datas.calendarLaunchFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Launch")
                                            datas.calendarDinnerFoodListCall(email: userEmail, date: makeCurrentDate(), meal: "Dinner")
                                            
                                            index = 1
                                            
                                            isTabDate = true
                                            
                                            isLoading = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                                                isLoading = false

                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                withAnimation(.spring()){
                                                    isLoadingEnd = true
                                                }
                                            }
                                            
                                           
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
                                .padding(.top, 20)
                               
                              
                            }
                            .padding(.horizontal, 5)
                            
                           
                        }
                        
                        .padding()
                        .padding(.top, 120)
                        .padding(.bottom, isLoadingEnd ? 0 : 155)
                        .background(Color.white)
                        .cornerRadius(20)
                        .navigationBarTitleDisplayMode(.inline)
                        
                        
                        .onChange(of: currentMonth) { newValue in
                            
                            // updating Month...
                            currentDate = getCurrentMonth()
                        }
                       
                    }
                   
                }
                .zIndex(2)
                .frame(width: 400, height: 800, alignment: .center)
                .scaleEffect(isLoadingEnd ? 0.84 : 1)
                .offset(y: isLoadingEnd ? getRect().height - 80 : 0)
//                .rotationEffect(.init(degrees: isTabDate ? 45 : 0))
                .zIndex(4)
               
                
                if isTabDate{
                    VStack{
                       
                        if let task = tasks.first(where: { task in
                            return isSameDay(date1: task.taskDate, date2: currentDate)
                        }){
                            VStack(spacing : 0){
                                ForEach(task.task){task in

                                    HStack(spacing : 100){
                                        VStack{
                                         
                                           
                                        HStack{
                                            Text("\(extraDate()[0])/\(extraDate()[2])/\(makeDay())")
                                                .font(Font.custom(systemFont, size: 20))
                                                .padding(.trailing, 20)
                                            
//                                            Text("\(extraDate()[2])/")
//                                                .font(Font.custom(systemFont, size: 20))
//
//                                            Text("\(makeDay())/")
//                                                .font(Font.custom(systemFont, size: 20))
                                                    
                                            }
                                        }
                                        
                                            // For Custom Timing...
                                        HStack{
                                            Text("\(task.title)")
                                                .font(Font.custom(systemFont, size: 20))
                                                
                                               
                                            Text("kcal")
                                                .font(Font.custom(systemFont, size: 17))
                                               
                                        }
                                        
                                    }
                                    .padding(.bottom, 5)
                                   
                                }
                                Rectangle()
                                    .frame(width: 340, height: 1, alignment: .center)
                                    .foregroundColor(Color.init("systemColor"))
                                
                                VStack{
                                    Text(index == 1 ? "아침" : index == 2 ? "점심" : "저녁" )
                                        .font(Font.custom(systemFont, size: 28))
                                        .fontWeight(.bold)
                                   
                                }
                                .padding(.top, 15)
                                .padding(.bottom, 30)
                                .zIndex(1)
                                  
                                VStack{
                                    ZStack{

                                        CardDietView(mealString : "저녁",userImageURL: $calendarViewModel.dinnerImageURL, foodList: $datas.calendarDinnerFoodList, isTabDate : $isTabDate, index:$index, offset: $dinnerCardOffset)
                                            .scaleEffect(index == 3  ? 1 : 0.64)
                                            .offset(x: index == 3 ?  0 : getRect().width - 120, y : index == 3 ? 0 : 15 )
                                            .opacity(index == 3 ? 1 : 0.6)
                                            .zIndex(index == 3  ? 3 : 1)
                                           
                                        
                                        CardDietView(mealString : "점심",userImageURL: $calendarViewModel.launchImageURL, foodList: $datas.calendarLaunchFoodList, isTabDate: $isTabDate, index:$index, offset: $launchCardOffset)
                                            .scaleEffect(index == 2  ? 1 : 0.64)
                                            .offset(x: index == 2 ? 0 : index < 2 ? getRect().width - 120 : getRect().width - 660 , y : index == 2 ? 0 : 15 )
                                            .zIndex(index == 2  ? 3 : 2)
                                            .opacity(index == 2 ? 1 : 0.6)
                                          
                                        CardDietView(mealString : "아침",userImageURL: $calendarViewModel.morningImageURL, foodList: $datas.calendarMorningFoodList, isTabDate: $isTabDate, index:$index, offset: $morningCardOffset)
                                            .scaleEffect(index == 1 ? 1 : 0.64)
                                            .offset(x: index == 1 ?  0 : getRect().width - 660, y : index == 1 ? 0 : 15 )
                                            
                                            .zIndex(index == 1  ? 3 : 1)
                                            .opacity(index == 1 ? 1 : 0.6)
                                           
                                        
                                    }
                                    .padding(.bottom , 40)
                                }
                                
                                
                            
        
                                HStack{
                                    
                                       Button(action: {
                                        withAnimation(.spring()){
                                            isTabDate = false
                                            isLoadingEnd = false
                                            calendarViewModel.morningImageURL = ""
                                            calendarViewModel.launchImageURL = ""
                                            calendarViewModel.dinnerImageURL = ""
                                            
                                            morningCardOffset = 0
                                            launchCardOffset = 0
                                            dinnerCardOffset = 0
                                            
                                            index = 1
                                          
                                        }
                                        
                                        
                                    }, label: {
                                        ZStack{
                                            Image(systemName: "arrow.uturn.left")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .foregroundColor(.white)
                                                .zIndex(2)
                                            Circle()
                                                .frame(width: 70, height: 70, alignment: .center)
                                               
                                                .foregroundColor(Color.init("darkGreen"))
                                                .shadow(radius: 6, x: 2, y: 2)
                                        }
                                      
                                    })
                                 
                                }
                                .padding(.horizontal, 30)
                               
                                
                            }
                            .padding(.top, 35)
                           
                        }
                        else{

                            Text("정보가 없습니다")
                                .padding(.top, 30)
                        }
      
                        
                    }
                    .padding(.top, 35)
                    .zIndex(0)
                  
                }
              
                
            }
            
            
        }
        
        
        .background(
            Image("dietBack")
                .resizable()
                .frame(width: 390, height: 900, alignment: .center)
        )
        .ignoresSafeArea()
        
        .onAppear(){
            
            UITableView.appearance().separatorColor = .clear
            
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Breakfast.jpg", meal : "morning")
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Launch.jpg", meal : "launch")
            calendarViewModel.loadImageFromFirebase(path: "Diary/\(makeEmailString())/\(makeCurrentDate())/Dinner.jpg", meal : "dinner")
            
            currentDate = getCurrentMonth()
            datas.readCalendarData(email: userEmail)
            for data in datas.calendarData{
                tasks.append(TaskMetaData(task: [

                    Task(title: "\(data.kcal)")

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
    
    func makeDay() -> String {
        let date = currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    func makeCurrentDate() -> String {
        let date = currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMM dd"
        return formatter.string(from: date)
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
extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
