//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

protocol SendDataDelegate {
    var pointManger : PointManager { get set }
}

class BuyingViewController: UIViewController {
    
    var delegate: SendDataDelegate?
 
    @IBOutlet weak var currentPointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2-viewDidLoad")
        currentPointLabel.text = Int(100).description
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2-viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("2-viewdidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("2-viewwillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("2-viewDiddisappear")
    }
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buyDopbarButtonTapped(_ sender: UIButton) {
        delegate?.pointManger.point -= 50
        self.dismiss(animated: true, completion: nil)
        }
    }

