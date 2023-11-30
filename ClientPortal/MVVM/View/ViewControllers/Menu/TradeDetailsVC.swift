//
//  TradeDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class TradeDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileACTION(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
