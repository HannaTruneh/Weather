import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
    
    func toCelsiusAndRound() -> String {
        let celsius = self - 273.15
        return String(format: "%.0f", celsius) 
    }
}




