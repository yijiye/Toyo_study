//
//  Chargeable.swift
//  POP_test
//
//  Created by 리지 on 2023/03/11.
//

typealias WattPerHour = Int
typealias Watt = Int

protocol Chargeable {
    var maximumWattPerHour: WattPerHour { get }
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour
}
