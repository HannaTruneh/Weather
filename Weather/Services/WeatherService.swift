
import Foundation
import CoreLocation

class WeatherService {
    func getCurrentWeather(latitude: CLLocationDegrees, longitud: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitud)&appid=51088ac0b7422fe26336dc2c8a5b2fde") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data") }
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        print("Weather data: \(decodeData)")
        
        return decodeData
        
    }
    
    func getWeatherByCityName(cityName: String) async throws -> ResponseBody {
        let encodedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCityName)&appid=51088ac0b7422fe26336dc2c8a5b2fde") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Weather API", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
        }
        
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        print("Weather data: \(decodeData)")
        
        return decodeData
        
    }
}

