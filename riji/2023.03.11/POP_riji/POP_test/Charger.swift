//
//  Charger.swift
//  POP_test
//
//  Created by 리지 on 2023/03/11.
//
struct Charger: Chargeable, Portable {
    var maximumWattPerHour: WattPerHour
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour {
        chargeableWattPerHour > maximumWattPerHour ? chargeableWattPerHour : maximumWattPerHour
    }
}

let watchCharger = Charger(maximumWattPerHour: 5)
let iPhoneCharger = Charger(maximumWattPerHour: 18)
let iPadCharger = Charger(maximumWattPerHour: 30)
let macBookCharger = Charger(maximumWattPerHour: 96)
let macCharger = Charger(maximumWattPerHour: 106)
