import SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Weather")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.horizontal)
            
            TextField("Enter City", text: $searchViewModel.cityName)
                .padding()
                .submitLabel(.search)
                .onSubmit {
                    searchViewModel.performSearch()
                }
            
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                .padding(.bottom, 20)
            
            Spacer()
            
            if searchViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            }
        }
        .sheet(isPresented: $searchViewModel.showBottomSheet) {
            if let weather = searchViewModel.weather {
                CityWeatherView(weather: weather)
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        })
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.grayn, Color.grayn]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SearchView()
}
