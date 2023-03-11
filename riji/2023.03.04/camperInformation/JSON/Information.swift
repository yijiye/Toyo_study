//
//  Information.swift
//  camperInformation
//
//  Created by jiye Yi on 2023/03/04.
//

struct Information: Decodable {
    let name: String
    let generation: Int
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case generation = "기수"
        case phone = "사용하는 휴대폰 정보"
    }
}
