//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

struct Registrant {
    var name: String
    var phoneNumber: String
    
}

let center: NotificationCenter = NotificationCenter.default

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    var registrantList: [Registrant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register()
       
        // Do any additional setup after loading the view.
    }
    
    // 등록하기 버튼을 눌렀을 때 Notification Center 로 알림을 전달 (post), 변화가 있음을 포스팅
    @IBAction func hitRegisterButton(_ sender: Any) {
        guard let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text else {
            return
        }
        registrantList.append(Registrant(name: name, phoneNumber: phoneNumber))
        let enrolledRegistrant = [NotificationKey.name: name,  NotificationKey.phoneNumber: phoneNumber]
        //        showAlert(message: "등록이 완료되었습니다.")
        
        /*
         name: Notification.Name으로 알림을 식별
         object: 특정 sender의 알림을 받고싶을 때 설정, nil을 해놓으면 모든 알림을 받을 수 있다.
         userInfo: notification과 관련된 값, 변화한 값을 전달
         */
        NotificationCenter.default.post(name: Notification.Name.regist, object: nil, userInfo: enrolledRegistrant)
        
    }
    
    //    @IBAction func hitCheckButton(_ sender: Any) {
    //        nameLabel.text = nameTextField.text
    //        phoneNumberLabel.text = phoneNumberTextField.text
    //    }
    //
    
    func register() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayRegistrantLabel(_:)), name: Notification.Name.regist, object: nil)
    }
    
    @objc func displayRegistrantLabel(_ notification: Notification) {
        guard let name = notification.userInfo?[NotificationKey.name] as? String else {
            return
        }
        guard let phoneNumber = notification.userInfo?[NotificationKey.phoneNumber] as? String else {
            return
        }
        self.nameLabel.text = name
        self.phoneNumberLabel.text = phoneNumber
        
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ (action) in }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// 전달하고자 하는 알림의 이름 (이걸 통해 알림을 식별한다)
extension Notification.Name {
    static let regist = Notification.Name("regist")
}

// Notification과 관련된 인스턴스
enum NotificationKey {
    case name
    case phoneNumber
}

