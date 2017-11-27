import UIKit

extension String {
    func containsOnlyDigits() -> Bool {
        let digits = NSCharacterSet.decimalDigits
        for char in self.unicodeScalars {
            if !(digits as NSCharacterSet).longCharacterIsMember(char.value) {
                return false
            }
        }
        return true
    }
}
