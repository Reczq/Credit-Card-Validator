protocol APIManagerProtocol {
    var baseURL: String { get }
    var format: String { get }
    var APIKey: String { get }
    var parser: APIResultParserProtocol { get }

    init(with baseURL: String, parser: APIResultParserProtocol)

    func search(with cardCode: String, completion: @escaping ([APIResultModelProtocol]) -> ())
}
