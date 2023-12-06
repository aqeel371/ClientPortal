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
        getAccounts()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Variables
    var spinner:LoadingViewNib?
    var liveAccounts = [AccountsDatum]()
    var demoAccounts = [AccountsDatum]()
    
    //MARK: - IBACtions
    
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
        vc.accounts = liveAccounts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func demoAction(_ sender: Any) {
        let vc = ViewControllers.AccountsVC.getViewController() as AccountsVC
        vc.titleVC = "Demo"
        vc.accounts = demoAccounts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func actionChangePass(_ sender: Any) {
        let vc = ViewControllers.ChangePasswordVC.getViewController() as ChangePasswordVC
        vc.accountTypes = self.liveAccounts
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK: - API
extension MenuAccountsVC{
    
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
                                    self.liveAccounts.append(acc)
                                }else{
                                    self.demoAccounts.append(acc)
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
