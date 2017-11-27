import UIKit

struct TextFieldSizes {
    static let placeholder = "1234 1234 1234 1234 MM/YY CVC"
    static let cornerRadius: CGFloat = 1.0
    static let shadowRadius: CGFloat = 1.0
    static let masksToBounds = false
    static let shadowOffset = CGSize(width: 1.0, height: 1.0)
    static let shadowOpacity: Float = 1
}

struct ButtonsSizes {
    static let cornerRadius: CGFloat = 15.0
    static let masksToBounds = false
    static let shadowRadius: CGFloat = 1.0
    static let offsetRadius = CGSize(width: 1.0, height: 1.0)
    static let shadowOpacity: Float = 1
    static let alpha: CGFloat = 0.3
}

struct TextfieldConstrainsValues {
    static let top = 70
    static let left = 4
    static let right = 4
    static let height = 45
}

struct GenerateButtonConstrainsValues {
    static let top = 5
    static let left = 3
    static let right = -5
    static let height = 75
}

struct ValidateButtonConstrainsValues {
    static let top = 5
    static let right = -3
    static let height = 75
}

struct ResultLabelConstraintsValues {
    static let cornerRadius: CGFloat = 20.0
    static let alpha: CGFloat = 0
    static let bottom = -10
    static let size: CGSize = CGSize(width: 55.0, height: 55.0)
}
