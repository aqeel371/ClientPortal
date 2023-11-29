//
//  MenuTransactionVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuTransactionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func depositAction(_ sender: Any) {
    }
    
    @IBAction func withdrawAction(_ sender: Any) {
    }
    
    @IBAction func internalAction(_ sender: Any) {
    }
    
    
    @IBAction func bankAction(_ sender: Any) {
    }
    
    @IBAction func walletAction(_ sender: Any) {
    }
    
    @IBAction func reportAction(_ sender: Any) {
    }
    
    
}
