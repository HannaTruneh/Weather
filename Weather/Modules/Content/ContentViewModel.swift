import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var weather: ResponseBody?
    @Published var weatherState: WeatherState = .idle
    @Published var errorMessage: String?
    
    private var weatherService = WeatherService()
    
    
    enum WeatherState: Equatable {
        case idle, loading, success, error
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        
        weatherState = .loading
        
        if let fetchedWeather = try? await weatherService.getCurrentWeather(latitude: latitude, longitud: longitude) {
            weather = fetchedWeather
            weatherState = .success
        } else {
            errorMessage = "Error fetching weather data"
            weatherState = .error
        }
    }
}


