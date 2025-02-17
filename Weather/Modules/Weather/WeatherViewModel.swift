
import Foundation

func isDayTime() -> Bool {
    let hour = Calendar.current.component(.hour, from: Date())
    return hour >= 6 && hour < 18
}
