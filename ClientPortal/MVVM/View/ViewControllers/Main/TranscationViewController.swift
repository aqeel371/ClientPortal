//
//  TranscationViewController.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import UIKit

class TranscationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
}
