//
//  Campers.swift
//  JSonTraining
//
//  Created by kimseongjun on 2023/03/04.
//

import Foundation

struct Campers: Decodable {
    let name: String
    let gisu: Int
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case gisu
        case phoneNumber = "phone_number"
    }
}
