//
//  MenuVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func accountsAction(_ sender: Any) {
        let vc = ViewControllers.MenuAccountsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func transactionAction(_ sender: Any) {
        let vc = ViewControllers.MenuTransactionVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tradesAction(_ sender: Any) {
        let vc = ViewControllers.MenuTardesVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func trainingAction(_ sender: Any) {
        let vc = ViewControllers.MenuTrainingVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func plateformAction(_ sender: Any) {
    }
    
    @IBAction func userProfileAction(_ sender: Any) {
        let vc = ViewControllers.MenuProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
