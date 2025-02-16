import SwiftUI

struct SearchView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherService()
    @State var weather: ResponseBody?
    @State var cityName = ""
    @State private var showBottomSheet = false
    @State private var isLoading = false
    
    var body: some View {
        
        VStack {
            Text("Weather")
                .font(.system(size: 40, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .padding()
            
            TextField("Search City", text: $cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .submitLabel(.search)
                .onSubmit {
                    performSearch()
                }
                .padding(.horizontal)
            
            Spacer()
            
            if isLoading {
                ProgressView()
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            if let weather = weather {
                CityWeatherView(weather: weather)
            }
        }
        .navigationTitle("")
    }
    
    private func performSearch() {
        isLoading = true
        
        Task {
            do {
                let fetchedWeather = try await weatherManager.getWeatherByCityName(cityName: cityName)
                weather = fetchedWeather
                showBottomSheet = true
            } catch {
                print("Error fetching weather: \(error)")
            }
            isLoading = false
        }
    }
}

#Preview {
    SearchView()
}

