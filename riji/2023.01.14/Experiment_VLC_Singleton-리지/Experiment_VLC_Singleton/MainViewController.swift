//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class PointManager {
    var point: Int = 100
}

class MainViewController: UIViewController, SendDataDelegate {
    var pointManger: PointManager = PointManager()
    
    
    @IBOutlet weak var currentPointLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var initializeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("1-viewdidload")
        pointLabel.text = Int(100).description
   
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("1-viewWillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("1-viewdidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("1-viewwillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("1-viewDiddisappear")
    }
    
    @IBAction func initializeButtonTapped(_ sender: UIButton) {
        pointLabel.text = pointManger.point.description
    }
    
    @IBAction func nextPageButtonTapped(_ sender: UIButton) {
        //뷰컨에 인스턴스 생성하는 작업 (vc, vc2 생성)
        guard let vc = self.storyboard?.instantiateViewController(identifier: "BuyingViewController") as? BuyingViewController else { return }
//        guard let vc2 = self.storyboard?.instantiateViewController(identifier: "BuyingViewController") as? BuyingViewController else { return }
        vc.delegate = self // vc에만 위임
        self.present(vc, animated: true, completion: nil) // vc2화면을 띄움 (vc변화 확인x)
    }

}
