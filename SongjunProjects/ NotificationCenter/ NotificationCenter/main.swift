////
////  main.swift
////   NotificationCenter
////
////  Created by kimseongjun on 2023/01/05.
////
//// KVO
//import Foundation
////
////class Bank: NSObject {
////    @objc dynamic var jango: Int = 100
////}
////
////class BankManager: NSObject {
////    @objc var bank: Bank
////    var observation: NSKeyValueObservation?
////
////    init(bank: Bank) {
////        self.bank = bank
////
////        super.init() // 순서가 중요한 이융 init하면서 메모리를 할당 받기 때문에 그전에는 값을 넣지 못함!
////
////        observation = observe(\.bank.jango,
////                               options: [.old, .new],
////                               changeHandler: { manager, change in // 잔고가 바뀔 때 호출되는 클로저 // manager는 지켜보는 객체 // change는 변한 값
////            print("은행 잔고가 변경됐습니다 : \(change.oldValue) -> \(change.newValue)")
////
////        })
////    }
////
////}
////
////let hankookBank: Bank = Bank()
////let manager: BankManager = BankManager(bank: hankookBank)
////
////hankookBank.jango = 99// hankookBank의 프로퍼티 값이 변하면 지켜보고 있다가 실행을 한다.
//
////MARK: KVO
//
import Foundation
class Friend: NSObject {
    @objc dynamic var candy: Int = 30
}

class Me: NSObject {
    @objc var friend: Friend
    var observation: NSKeyValueObservation?

    init(friend: Friend) {
        self.friend = friend
        super.init()

        observation = observe(\.friend.candy, // 변경 감지 대상(friend의 candy가 변경을 감지한다)
                               options: [.old, .new], // 잘 모르겠어요..그냥 변경되기 전, 변경된 후 두개로 설정한다는 뜻이겠죠..
                               changeHandler: { manager, change in // 변경 감지 대상이 변경될 때 호출되는 클로저(변경될 때 무슨 행동을 할지 정한다)
            print("사탕 몇개 있니? \(change.oldValue)개 있었는데 먹어서 \(change.newValue)개 남았어!")
        })
    }
}

let rowan: Friend = Friend()
let songjun: Me = Me(friend: rowan)

rowan.candy = 25
//
//
////
////
////// NotificationCenter
////
////class Youtuber {
////    var channelName: Notification.Name
////
////    init(channelName: Notification.Name) {
////        self.channelName = channelName
////    }
////
////    func broadcast() {
////        center.post(name: channelName, object: nil) // name에 notification이름 설정
////        //버튼이 눌린 것을 감지하여 값을 변경할 때
////    }
////}
////
////class Subcriber {
////    var name: String
////
////    init(name: String) {
////        self.name = name
////    }
////
////    func subscirbe(_name: Notification.Name) {
////        center.addObserver(self, // 누가 옵저버인지 정하는듯?
////                           selector: #selector(didReceiveBroadCast), // 신호를 주면 여기 값이 변경된다.
////                           name: name, // Notification 이름 지정
////                           object: nil)
////    }
////
////    @objc func didReceiveBroadcast(_ notification: Notification) {
////        print("방송 시작!!")
////    }
////}
////
////let center: NotificationCenter = NotificationCenter.default // 기본 NotificationCenter 싱글톤 구조인거 같아요!
////
////let rillaNotificationName = Notification.Name("릴라튜브")
////let rhodeNotificationName = Notification.Name("로데튜브")
////
////let rilla: Youtuber = Youtuber(channelName: rillaNotificationName)
////let rhode: Youtuber = Youtuber(channelName: rhodeNotificationName)
////
////let kaki: Subcriber = Subcriber(name: "카키")
////let brody: Subcriber = Subcriber(name: "브로디")
////
////kaki.subscirbe(_name: rillaNotificationName)
//struct Person {
//    var kim: String = "kim"
//}
struct Address {
    var town: String
}

struct Person {
    var address: Address
}
let address = Address(town: "어쩌구")
let zedd = Person(address: address)

print(zedd.address)
print(zedd.address.town)

let zeddAddress = zedd[keyPath: \.address]
let zeddTown = zedd[keyPath: \.address.town]
print(zeddTown) // 어쩌구
