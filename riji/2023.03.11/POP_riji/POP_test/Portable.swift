//
//  Portable.swift
//  POP_test
//
//  Created by 리지 on 2023/03/11.
//

protocol Portable { }

struct Bag {
    private var items: [Portable] = []
    
    mutating func put(item: Portable) {
        items.append(item)
    }
}

var myChannel = Bag()
