import SwiftUI

struct BackgroundSubView: View {
    var isDay: Bool
    var weatherCondition: String
    
    @State private var sunPosition: CGFloat = UIScreen.main.bounds.width - 100
    @State private var moonPosition: CGFloat = UIScreen.main.bounds.width - 100
    @State private var backgroundColor: Color = Color.blue
    @State private var cloudPosition1: CGFloat = -200
    @State private var cloudPosition2: CGFloat = -100
    @State private var starPositions: [StarPosition] = []
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: gradientColors()),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut(duration: 3), value: backgroundColor)
            
            if isDay {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .position(x: sunPosition, y: UIScreen.main.bounds.height / 8)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 25).repeatForever(autoreverses: false)) {
                            sunPosition = UIScreen.main.bounds.width + 100
                        }
                    }
                HStack {
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 60)
                        .foregroundColor(.white)
                        .position(x: cloudPosition1, y: UIScreen.main.bounds.height / 14)
                    
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 50)
                        .foregroundColor(.white)
                        .position(x: cloudPosition2, y: UIScreen.main.bounds.height / 15)
                }
                .onAppear {
                    withAnimation(Animation.linear(duration: 40).repeatForever(autoreverses: false)) {
                        cloudPosition1 = UIScreen.main.bounds.width + 100
                    }
                    withAnimation(Animation.linear(duration: 40).repeatForever(autoreverses: false)) {
                        cloudPosition2 = UIScreen.main.bounds.width + 200
                    }
                }
                
            } else {
                Image(systemName: "moon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .position(x: moonPosition, y: UIScreen.main.bounds.height / 8)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 30).repeatForever(autoreverses: false)) {
                            moonPosition = UIScreen.main.bounds.width + 100
                        }
                    }
                ForEach(starPositions) { position in
                    Circle()
                        .frame(width: 4, height: 4)
                        .foregroundColor(.white)
                        .position(x: position.x, y: position.y)
                        .onAppear {
                            animateStar(star: position)
                        }
                }
            }
        }
        .onAppear {
            if !isDay {
                generateStars()
            }
        }
        .onChange(of: isDay) { newValue in
            if newValue {
                sunPosition = -100
                cloudPosition1 = -200
                cloudPosition2 = -400
            } else {
                moonPosition = UIScreen.main.bounds.width + 100
                generateStars()
            }
        }
    }
    
    private func gradientColors() -> [Color] {
        if isDay {
            switch weatherCondition.lowercased() {
            case "clear":
                return [Color.bluely, Color.white]
            case "clouds":
                return [Color.bluely, Color.white]
            case "rain":
                return [Color.bluely, Color.gray]
            default:
                return [Color.bluely, Color.white]
            }
        } else {
            return [Color.grayn, Color.gray]
        }
    }
    
    private func generateStars() {
        let starCount = 50
        var newStars: [StarPosition] = []
        
        for id in 0..<starCount {
            let randomX = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let randomY = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            newStars.append(StarPosition(id: id, x: randomX, y: randomY))
        }
        
        starPositions = newStars
    }
    
    private func animateStar(star: StarPosition) {
        withAnimation(Animation.linear(duration: 250).repeatForever(autoreverses: true)) {
            let randomY = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            let randomX = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            
            if let index = starPositions.firstIndex(where: { $0.id == star.id }) {
                starPositions[index].x = randomX
                starPositions[index].y = randomY
            }
        }
    }
}

struct StarPosition: Identifiable {
    var id: Int
    var x: CGFloat
    var y: CGFloat
}

#Preview {
    BackgroundSubView(isDay: false, weatherCondition: "clear")
}
