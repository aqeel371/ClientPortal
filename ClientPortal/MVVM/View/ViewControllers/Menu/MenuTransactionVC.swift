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
        let vc = ViewControllers.DepositVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func withdrawAction(_ sender: Any) {
        let vc = ViewControllers.InternalTabsVC.getViewController() as InternalTabsVC
        vc.typeVc = .withdraw
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func internalAction(_ sender: Any) {
        let vc = ViewControllers.InternalTabsVC.getViewController() as InternalTabsVC
        vc.typeVc = .transfer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func bankAction(_ sender: Any) {
        let vc = ViewControllers.BankAccountsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func walletAction(_ sender: Any) {
        let vc = ViewControllers.WalletsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reportAction(_ sender: Any) {
        let vc = ViewControllers.ReportsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
