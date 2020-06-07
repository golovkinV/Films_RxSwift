import Foundation


extension Int {
    func minuteToHoursMinutes() -> (Int, Int) {
      return (self / 60, self % 60)
    }
}
