import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .leading) {
                
                BackgroundSubView(isDay: isDayTime(), weatherCondition: weather.weather[0].main)
                
                VStack {
                    VStack(alignment: .trailing, spacing: 20) {
                        NavigationLink(destination: SearchView()) {
                                Image(systemName: "location.magnifyingglass")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                    .padding(.bottom)
                            Spacer()
                        }
                        .padding()
                    }
                    VStack {
                        Text(weather.name)
                            .bold().font(.title)
                        
                        Text(weather.main.feelsLike
                            .toCelsiusAndRound() + "°")
                        .font(.system(size: 100))
                        
                        Text(weather.weather[0].main)
                            .font(.title2)
                                                
                        Spacer()
                    }
                    .foregroundColor(Color.lightBlue)
                }

                VStack {
                    Spacer()
                    
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
                    .foregroundColor(Color.lightBlue)
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
                
            }
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
