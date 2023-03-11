//
//  main.swift
//  POP_test
//
//  Created by 리지 on 2023/03/11.
//

let myMac = MacBook(currentBatteryWH: 30)
myMac.chargeBattery(charger: iPhoneCharger)
myMac.chargeBattery(charger: watchCharger)
myMac.chargeBattery(charger: iPadCharger)
myMac.chargeBattery(charger: macCharger)
myMac.chargeBattery(charger: macBookCharger)

myChannel.put(item: myMac)
myChannel.put(item: macBookCharger)
