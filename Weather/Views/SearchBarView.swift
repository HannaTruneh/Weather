
import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var cityName = ""
    @State private var showBottomSheet = false
    @State private var isLoading = false
    
    
    var body: some View {
        VStack {
            Text("Enter City")
                .searchable(text: $cityName)
        } 
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant("Test"))
}
