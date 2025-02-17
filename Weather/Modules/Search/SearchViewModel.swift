import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherService()
    
    @Published var weather: ResponseBody?
    @Published var showBottomSheet = false
    @Published var isLoading = false
    @Published var cityName = ""
    
    
    func performSearch() {
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
