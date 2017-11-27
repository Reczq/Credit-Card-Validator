import SwiftyJSON

struct APICreditCardParser: APIResultParserProtocol {

    func parse (data: JSON) -> [APIResultModelProtocol] {
        var models = [CreditCardModel]()

        guard let items = data.dictionary else { return models }

        let valid = (items["valid"]?.stringValue != nil) ? items["valid"]?.stringValue : ""
        let model = CreditCardModel(valid: valid!)

        models.append(model)
        return models
    }
}
