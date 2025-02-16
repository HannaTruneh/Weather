
import SwiftUI

struct CityWeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .leading) {
                
                BackgroundView(isDay: isDayTime(), weatherCondition: weather.weather[0].main)
                
                VStack {
                    
                    VStack {
                        
                        Spacer()
                        
                        Text(weather.name)
                            .bold().font(.title)
                        
                        Text(weather.main.feelsLike
                            .toCelsiusAndRound() + "°")
                        .font(.system(size: 100))
                        
                        Text(weather.weather[0].main)
                            .font(.title2)
                    }
                    .foregroundColor(Color.lightBlue)

                    
                    Spacer()
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                    
                    VStack {
                        
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Weather now")
                                    .bold()
                                    .padding(.bottom)
                            }
                            
                            HStack {
                                WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.toCelsiusAndRound() + "°"))
                                
                                Spacer()
                                
                                WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.toCelsiusAndRound() + "°"))
                            }
                            
                            HStack {
                                WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                
                                Spacer()
                                
                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 20)
                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                        .background(.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                    }
                }
            }
        }
    }
}
#Preview {
    CityWeatherView(weather: previewWeather)
}
