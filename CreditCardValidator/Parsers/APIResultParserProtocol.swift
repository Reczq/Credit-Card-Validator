import SwiftyJSON

protocol APIResultParserProtocol {
    func parse(data: JSON) -> [APIResultModelProtocol]
}
