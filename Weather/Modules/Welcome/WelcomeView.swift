import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.grayn, Color.grayn]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 20) {
                    Text("Welcom to the Weather App")
                        .bold().font(.title)
                    
                    Text("Please share your current location to get the weather in your area")
                        .padding()
                }
                .foregroundColor(Color.lightBlue)
                .multilineTextAlignment(.center)
                .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    WelcomeView()
}
