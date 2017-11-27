class APICreditCardManager: APIManagerProtocol {

    let baseURL: String
    let format: String
    let APIKey: String
    let parser: APIResultParserProtocol

    required init(with baseURL: String, parser: APIResultParserProtocol) {
        self.baseURL = baseURL
        self.format = "/json"
        self.APIKey = "/5232a9bca11e25c0f8eb4313ff2644be/"
        self.parser = parser
    }
}
