



import SwiftUI
struct FirstBtn: View {
    var body: some View {
     NavigationLink(
        destination: GetBodyInfoView(),
        label: {
            Text("처음이신가요?")
                .foregroundColor(.black)
                .font(Font.custom(systemFont, size: 15))
                .fontWeight(.semibold)
                .frame(width: 300, height: 47, alignment: .center)
                .background(Color.init("userPink"))
                .cornerRadius(5)
                .padding()
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .shadow(color: .black, radius: 0.8)
    }
}

struct FirstBtn_Previews: PreviewProvider {
    static var previews: some View {
        FirstBtn()
    }
}
