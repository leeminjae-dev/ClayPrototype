import SwiftUI


import Combine

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}

struct ex: View {
    @ObservedObject var textBindingManager = TextBindingManager(limit: 5)
    @State var transitionView : Bool = false
    var body: some View {
        VStack{
        Button(action: {
                transitionView.toggle()
            
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
        if transitionView {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                //밑에서 등장해서 왼쪽으로 사라짐
                .transition(.asymmetric(insertion: AnyTransition.move(edge: .bottom),
                                        removal: AnyTransition.move(edge: .leading)))
                .animation(.easeIn)
        }
        }
    }
}

struct ex_Previews : PreviewProvider{
    static var previews: some View{
        ex()
    }
}
