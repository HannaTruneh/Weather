import SwiftUI


class WeatherViewModel: ObservableObject {
    
    @Published var weather: ResponseBody?
    @Published var weatherState: WeatherState = .idle
    @Published var errorMessage: String?
    
    private var weatherManager = WeatherManager()
    
    
    enum WeatherState: Equatable {
        case idle, loading, success, error
    }

    func loadWeather(latitude: Double, longitude: Double) async {
        weatherState = .loading
        
        do {
            let fetchedWeather = try await weatherManager.getCurrentWeather(latitude: latitude, longitud: longitude)
            weather = fetchedWeather
            weatherState = .success
        } catch {
            errorMessage = "Error fetching weather data"
            weatherState = .error
        }
    }
}
