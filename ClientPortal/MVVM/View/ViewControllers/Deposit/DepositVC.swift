//
//  DepositVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class DepositVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   //MARK: IBActions
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func internalTransferAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Instant
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func wireTransferAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Wire
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cryptoDetailsAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Crypto
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moneyAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .PerfectMoney
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func stickPayAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Stick
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func skrillAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Skrill
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
