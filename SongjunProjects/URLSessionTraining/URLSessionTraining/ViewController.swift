//
//  ViewController.swift
//  URLSessionTraining
//
//  Created by kimseongjun on 2023/03/25.
//

import UIKit

class ViewController: UIViewController {
    let urlManager = URLManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        urlManager.postAPI()
    }


}

