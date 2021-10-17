//import SwiftUI
//
//struct ProgressBar: View {
//    
//   
//    @Binding var targetArchieveRate : Float
//    @Binding var archieveRate : Float
//    
//    var body: some View {
//        
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Capsule()
//                    .frame(width: geometry.size.width , height: geometry.size.height)
//                    .opacity(0.3)
//                    .foregroundColor(Color("systemColor"))
//                
//                Capsule()
//                    .frame(width: min(CGFloat(self.targetArchieveRate * 0.033333)*geometry.size.width, geometry.size.width), height: geometry.size.height)
//                    .opacity(0.5)
//                    .foregroundColor(Color("systemColor"))
//                    .animation(.linear)
//                
//                Capsule()
//                    .frame(width: min(CGFloat(self.archieveRate * 0.033333)*geometry.size.width, geometry.size.width), height: geometry.size.height)
//                    .foregroundColor(Color("systemColor"))
//                    .animation(.linear)
//                
//            }.cornerRadius(45.0)
//            
//        }
//    }
//}
//
//
