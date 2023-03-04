//
//  Model.swift
//  JSONTable
//
//  Created by Harry on 2023/03/04.
//

import Foundation

struct Item: Codable {
    let name: String
    let cardinalNumber: String
    let model: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case cardinalNumber = "cardinal_number"
        case model
    }
}

typealias Items = [Item]
