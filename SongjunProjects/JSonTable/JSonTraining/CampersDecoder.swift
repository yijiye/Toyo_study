//
//  CampersDecoder.swift
//  JSonTraining
//
//  Created by kimseongjun on 2023/03/04.
//

import UIKit

struct CampersDecoder {
    private(set) var campers: [Campers] = []
    
    mutating func decodeData() throws {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "amooge") else { return }
        
        do {
            campers = try jsonDecoder.decode([Campers].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
