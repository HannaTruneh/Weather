import SwiftUI

struct SearchBarSubView: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack {
            Text("Enter City")
                .searchable(text: $text)
        }
        .padding()
    }
}

#Preview {
    SearchBarSubView(text: .constant("Test"))
}
