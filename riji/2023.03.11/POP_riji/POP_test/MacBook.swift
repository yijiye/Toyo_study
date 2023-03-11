//
//  MacBook.swift
//  POP_test
//
//  Created by 리지 on 2023/03/11.
//
struct MacBook: Portable {
    let deviceAllowableWH: Int = 20
    var currentBatteryWH: Int
    let maximumBatteryWH: Int = 100
    
    func chargeBattery(charger: Chargeable) {
        var time: Int = 0
        var neededBattery = maximumBatteryWH - currentBatteryWH // 충전이 필요한 배터리의 양
        let chargeBattery = charger.convert(chargeableWattPerHour: deviceAllowableWH) // 충전기를 이용하여 충전하는 배터리의 양
        
        while neededBattery > 0 {
            neededBattery -= chargeBattery // 충전이 필요한 양 - 충전하고 있는 양
            time += 1
        }
        
        print("충전하는데 걸린 시간은 약 \(time)시간 입니다.")
    }
}
