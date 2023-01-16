//
//  Animal.swift
//  AnimalToKnow
//
//  Created by Илья Валито on 05.09.2022.
//

import Foundation

struct AnimalData: Codable {
    let name: String
    let latinName: String
    let type: String
    let activeTime: String
    let minLength: String
    let maxLength: String
    let minWeight: String
    let maxWeight: String
    let lifespan: String
    let habitat: String
    let diet: String
    let geography: String
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, lifespan, habitat, diet
        case latinName = "latin_name"
        case type = "animal_type"
        case activeTime = "active_time"
        case minLength = "length_min"
        case maxLength = "length_max"
        case minWeight = "weight_min"
        case maxWeight = "weight_max"
        case geography = "geo_range"
        case image = "image_link"
    }
}
    
