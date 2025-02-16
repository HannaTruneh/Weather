
import SwiftUI

struct SearchBarSubView: View {
    
    @Binding var text: String
    var weatherManager = WeatherService()
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
    SearchBarSubView(text: .constant("Test"))
}
