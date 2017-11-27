import UIKit

struct APIManager {

    let baseURL = "https://api.bincodes.com/cc"

    func createCreditCardManager() -> APIManagerProtocol {
        let parser = APICreditCardParser()
        return APICreditCardManager(with: baseURL, parser: parser)
    }
}
