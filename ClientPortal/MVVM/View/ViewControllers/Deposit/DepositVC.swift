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
        getAccounts()
        // Do any additional setup after loading the view.
    }
    
    var spinner:LoadingViewNib?
    var liveAccount = [AccountsDatum]()
    

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
        vc.liveAccount = self.liveAccount
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
        vc.liveAccount = self.liveAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func stickPayAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Stick
        vc.liveAccount = self.liveAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func skrillAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.vcType = .Skrill
        vc.liveAccount = self.liveAccount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - API
extension DepositVC{
    
    func getAccounts(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Accounts, completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:AccountsResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        if let accounts = accResp.result?.data{
                            for acc in accounts{
                                if acc.type == "LIVE"{
                                    self.liveAccount.append(acc)
                                }
                            }
                        }
                    }else{
                        self.showAlert(title: "Error", message: accResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
    
}
