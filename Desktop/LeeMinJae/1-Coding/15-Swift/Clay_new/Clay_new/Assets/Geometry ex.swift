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
    
    var body: some View {
        TextField("Placeholder", text: $textBindingManager.text)
    }
}

struct ex_Previews : PreviewProvider{
    static var previews: some View{
        ex()
    }
}
