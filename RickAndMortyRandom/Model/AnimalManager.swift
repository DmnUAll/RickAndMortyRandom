//
//  AnimalManager.swift
//  AnimalToKnow
//
//  Created by Илья Валито on 05.09.2022.
//

import Foundation

protocol AnimalManagerDelegate {
    func updateUI(with data: AnimalData)
}

struct AnimalManager {
    
    var delegate: AnimalManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: "https://zoo-animal-api.herokuapp.com/animals/rand") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error as Any)
                    return
                }
                if let safeData = data {
//                    let dataStrng = String(data: safeData, encoding: .utf8)
//                    print(dataStrng)
                    self.parseJSON(animalData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(animalData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AnimalData.self, from: animalData)
            delegate?.updateUI(with: decodedData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
