import Foundation

enum DateDigits: Int {
    case FirstDigitOfMonth = 0, SecondDigitOfMonth, FirstDigitOfYear, SecondDigitOfYear
}

struct RandomCreditCardCodeGenerator {

    private let _startingIndex = 0
    private let _cardLength = 16
    private let _dateLength = 4
    private let _cvcLength = 3

    func getFullCreditCardCode() -> String {
        return generateCreditCardNumber() + generateExpirydDate() + generateCVC()
    }

    func getFullCreditCardCodeWithSeparations() -> String {
        let codeNumber = addSeparations(cardNumber: generateCreditCardNumber(), expiredDate: generateExpirydDate())

        return codeNumber + generateCVC()
    }

    private func addSeparations(cardNumber: String, expiredDate: String) -> String {
        var mutableCardNumber = cardNumber
        var mutableExpiredDate = expiredDate

        mutableCardNumber.insert(" ", at: mutableCardNumber.index(mutableCardNumber.startIndex, offsetBy: 4))
        mutableCardNumber.insert(" ", at: mutableCardNumber.index(mutableCardNumber.startIndex, offsetBy: 9))
        mutableCardNumber.insert(" ", at: mutableCardNumber.index(mutableCardNumber.startIndex, offsetBy: 14))
        mutableCardNumber.insert(" ", at: mutableCardNumber.index(mutableCardNumber.startIndex, offsetBy: 19))

        mutableExpiredDate.insert("/", at: mutableExpiredDate.index(mutableExpiredDate.startIndex, offsetBy: 2))
        mutableExpiredDate.insert(" ", at: mutableExpiredDate.index(mutableExpiredDate.startIndex, offsetBy: 5))

        return mutableCardNumber + mutableExpiredDate
    }

    private func generateCreditCardNumber() -> String {
        var cardNumber = [Int](repeating: 0, count: _cardLength)

        for i in _startingIndex..<cardNumber.count {
            cardNumber[i] = Int(arc4random_uniform(10))
        }

        return cardNumber.map({ String($0) }).joined(separator: "")
    }

    private func generateExpirydDate() -> String {
        var dateNumber = [Int](repeating: 0, count: _dateLength)

        for i in _startingIndex..<dateNumber.count {
            switch i {
            case DateDigits.FirstDigitOfMonth.rawValue:
                dateNumber[i] = Int(arc4random_uniform(2))
            case DateDigits.SecondDigitOfMonth.rawValue:
                dateNumber[i] = (dateNumber[0] == 0) ? (Int(arc4random_uniform(9)) + 1) : Int(arc4random_uniform(3))
            case DateDigits.FirstDigitOfYear.rawValue:
                dateNumber[i] = (Int(arc4random_uniform(9)) + 1)
            case DateDigits.SecondDigitOfYear.rawValue:
                dateNumber[i] = (dateNumber[2] == 1) ? (Int(arc4random_uniform(2)) + 8) : Int(arc4random_uniform(10))
            default:
                dateNumber[i] = Int(arc4random_uniform(10))
            }
        }

        let stringDateNumber = dateNumber.map({ String($0) }).joined(separator: "")

        return stringDateNumber
    }

    private func generateCVC() -> String {
        var cvcNumber = [Int](repeating: 0, count: _cvcLength)

        for i in _startingIndex..<cvcNumber.count {
            cvcNumber[i] = Int(arc4random_uniform(10))
        }

        return cvcNumber.map({ String($0) }).joined(separator: "")
    }
}
