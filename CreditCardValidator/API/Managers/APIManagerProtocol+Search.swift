import SwiftyJSON

extension APIManagerProtocol {

    func search(with cardCode: String, completion: @escaping ([APIResultModelProtocol]) -> ()) {

        let fullPath = baseURL + format + APIKey + cardCode

        guard let url = URL(string: fullPath) else { return }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let jsonData = JSON(data: data)
                let result = self.parser.parse(data: jsonData)
                completion(result)
            }
        }
        task.resume()
    }
}
