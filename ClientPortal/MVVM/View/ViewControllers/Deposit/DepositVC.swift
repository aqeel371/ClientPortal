//
//  DepositVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class DepositVC: UIViewController {
    
    
    var wireBanks = [Banks]()
    var cyptoBanks = [Banks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccounts()
        addCrptoBanksData()
        addWireBanks()
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
        vc.banks = wireBanks
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cryptoDetailsAction(_ sender: Any) {
        let vc = ViewControllers.CryptoWireVC.getViewController() as CryptoWireVC
        vc.banks = cyptoBanks
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
    
    //MARK: - Add Banks
    func addCrptoBanksData(){
        var banks1 = [BankData]()
        banks1.append(BankData(title: "Network",value: "Tether (USDT) | TRC20"))
        banks1.append(BankData(title: "Note",value: "Ensure the network is Tron (TRC20)"))
        banks1.append(BankData(title: "Address",value: "TLu3ozcMbyaQcFp9o46kaUTzscQ2cJjHgg"))
        cyptoBanks.append(Banks(icon: "ic_bank1", title: "Tether | TRC20", banksData: banks1,qrCode: "ic_Tether_TRC20"))
        
        
        var banks2 = [BankData]()
        banks2.append(BankData(title: "Network",value: "Tether (USDT) | ERC20"))
        banks2.append(BankData(title: "Note",value: "Ensure the network is Ethereum (ERC20)"))
        banks2.append(BankData(title: "Address",value: "0xf2B103B58ed60B63E6b2FBFBa48227EBc00C6995"))
        cyptoBanks.append(Banks(icon: "ic_bank2", title: "Tether | ERC20", banksData: banks2,qrCode: "ic_Tether_ERC20"))
        
        
        var banks3 = [BankData]()
        banks3.append(BankData(title: "Network",value: "USD Coin (USDC) | TRC20"))
        banks3.append(BankData(title: "Note",value: "Ensure the network is Tron (TRC20)"))
        banks3.append(BankData(title: "Address",value: "TLu3ozcMbyaQcFp9o46kaUTzscQ2cJjHgg"))
        cyptoBanks.append(Banks(icon: "ic_bank3", title: "USDC Coin | TRC20", banksData: banks3,qrCode: "ic_USDC_TRC20"))
        
        
        var banks4 = [BankData]()
        banks4.append(BankData(title: "Network",value: "USD Coin (USDC) | ERC20"))
        banks4.append(BankData(title: "Note",value: "Ensure the network is Ethereum (ERC20)"))
        banks4.append(BankData(title: "Address",value: "0xf2B103B58ed60B63E6b2FBFBa48227EBc00C6995"))
        cyptoBanks.append(Banks(icon: "ic_bank4", title: "USDC Coin | ERC20", banksData: banks4,qrCode: "ic_USDC_ERC20"))
    }
    
    func addWireBanks(){
        var banks1 = [BankData]()
        banks1.append(BankData(title: "Currencies",value: "USD - Account For Client"))
        banks1.append(BankData(title: "Beneficiary Bank Name",value: "AfrAsia Bank Ltd"))
        banks1.append(BankData(title: "Beneficiary Account",value: "GODO LTD - CLIENT ACCOUNT"))
        banks1.append(BankData(title: "Beneficiary Address",value: "3rd Floor, Standard Chartered Tower,                               Cybercity, Ebene, 72201, Mauritius"))
        banks1.append(BankData(title: "Bank Address",value: "Bowen Square 10, Dr Ferriere Street,                               Port Louis, Mauritius"))
        banks1.append(BankData(title: "Account Number",value: "094183000000054"))
        banks1.append(BankData(title: "IBAN Code",value: "MU10AFBL2501094183000000054USD"))
        banks1.append(BankData(title: "SWIFT Code",value: "AFBLMUMU"))
        banks1.append(BankData(title: "Minimum Amount",value: "500 USD"))
        wireBanks.append(Banks(icon: "ic_asiaBank", title: "AfrAsia Bank USD", banksData: banks1))
        
        var banks2 = [BankData]()
        banks2.append(BankData(title: "Currencies",value: "EUR - Account For Client"))
        banks2.append(BankData(title: "Beneficiary Bank Name",value: "AfrAsia Bank Ltd"))
        banks2.append(BankData(title: "Beneficiary Account",value: "GODO LTD - CLIENT ACCOUNT"))
        banks2.append(BankData(title: "Beneficiary Address",value: "3rd Floor, Standard Chartered Tower,                               Cybercity, Ebene, 72201, Mauritius"))
        banks2.append(BankData(title: "Bank Address",value: "Bowen Square 10, Dr Ferriere Street,                               Port Louis, Mauritius"))
        banks2.append(BankData(title: "Account Number",value: "094183000000054"))
        banks2.append(BankData(title: "IBAN Code",value: "MU10AFBL2501094183000000054USD"))
        banks2.append(BankData(title: "SWIFT Code",value: "AFBLMUMU"))
        banks2.append(BankData(title: "Minimum Amount",value: "500 EUR"))
        wireBanks.append(Banks(icon: "ic_asiaBank", title: "AfrAsia Bank EUR", banksData: banks2))
        
        var banks3 = [BankData]()
        banks3.append(BankData(title: "Currencies",value: "AED - Account For Client"))
        banks3.append(BankData(title: "Beneficiary Bank Name",value: "AfrAsia Bank Ltd"))
        banks3.append(BankData(title: "Beneficiary Account",value: "GODO LTD - CLIENT ACCOUNT"))
        banks3.append(BankData(title: "Beneficiary Address",value: "3rd Floor, Standard Chartered Tower,                               Cybercity, Ebene, 72201, Mauritius"))
        banks3.append(BankData(title: "Bank Address",value: "Bowen Square 10, Dr Ferriere Street,                               Port Louis, Mauritius"))
        banks3.append(BankData(title: "Account Number",value: "094183000000054"))
        banks3.append(BankData(title: "IBAN Code",value: "MU10AFBL2501094183000000054USD"))
        banks3.append(BankData(title: "SWIFT Code",value: "AFBLMUMU"))
        banks3.append(BankData(title: "Minimum Amount",value: "1000 AED"))
        wireBanks.append(Banks(icon: "ic_asiaBank", title: "AfrAsia Bank AED", banksData: banks3))
        
        var banks4 = [BankData]()
        banks4.append(BankData(title: "Currency",value: "AED"))
        banks4.append(BankData(title: "Beneficiary Bank Name",value: "Commercial Bank of Dubai"))
        banks4.append(BankData(title: "Beneficiary",value: "GODO LTD"))
        banks4.append(BankData(title: "Account No.",value: "2002284426"))
        banks4.append(BankData(title: "Swift Code*",value: "CBDUAEAD"))
        banks4.append(BankData(title: "IBAN Number",value: "AE620230000002002284426"))
        
        wireBanks.append(Banks(icon: "ic_cbd", title: "Commercial Bank of Dubai", banksData: banks4))
        
        var banks5 = [BankData]()
        banks5.append(BankData(title: "Currency",value: "AED"))
        banks5.append(BankData(title: "Beneficiary Bank Name",value: "Equals Money"))
        banks5.append(BankData(title: "Beneficiary Account",value: "Godo Ltd Client"))
        banks5.append(BankData(title: "Beneficiary Address",value: "United Kingdom"))
        banks5.append(BankData(title: "Account Number",value: "99990801"))
        banks5.append(BankData(title: "IBAN Code",value: "GB61SPPV23188499990801"))
        banks5.append(BankData(title: "Swift Code",value: "SPPVGB2L"))
        banks5.append(BankData(title: "Minimum Amount",value: "500"))
        
        wireBanks.append(Banks(icon: "ic_equals", title: "Equals Money", banksData: banks5))
        
        
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
