extension CreditCardValidatorController {
    func getCreditCardDataFromRequestToAPI(with cardCode: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {

        cardManager.search(with: cardCode) { (model) in
            completion(model)
        }
    }
}
