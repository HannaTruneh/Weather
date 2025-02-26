import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherService()
    @State var weather: ResponseBody?
    
    var body: some View {
        
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitud: location.longitude)
                                
                            } catch {
                                print("Error getting weather")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color.grayn)
    }
}

#Preview {
    ContentView()
}

