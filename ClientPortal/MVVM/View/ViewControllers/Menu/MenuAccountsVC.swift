//
//  MenuAccountsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuAccountsVC: UIViewController {
    
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
    
    @IBAction func liveActiom(_ sender: Any) {
        let vc = ViewControllers.AccountsVC.getViewController() as AccountsVC
        vc.titleVC = "Live"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func demoAction(_ sender: Any) {
        let vc = ViewControllers.AccountsVC.getViewController() as AccountsVC
        vc.titleVC = "Demo"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
