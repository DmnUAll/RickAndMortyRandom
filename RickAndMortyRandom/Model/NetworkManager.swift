import Foundation

// MARK: - NetworkManagerDelegate protocol
protocol NetworkManagerDelegate: AnyObject {
    func updateUI(with data: CharacterModel)
}

// MARK: - NetworkManager
struct NetworkManager {

    var delegate: NetworkManagerDelegate?

    func performRequest() {
        let characterID = Int.random(in: 1...826)
        if let url = URL(string: "https://rickandmortyapi.com/api/character/\(characterID)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                if let safeData = data {
                    self.parseJSON(characterData: safeData)
                }
            }
            task.resume()
        }
    }

    func parseJSON(characterData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CharacterModel.self, from: characterData)
            delegate?.updateUI(with: decodedData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
