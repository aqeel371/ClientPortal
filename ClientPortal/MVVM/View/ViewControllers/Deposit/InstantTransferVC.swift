//
//  InstantTransferVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class InstantTransferVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfTradingAccount: UITextField!
    @IBOutlet weak var tfCurrency: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    
    //MARK: - Variables
    var spinner :LoadingViewNib?
    var instantPicker = UIPickerView()
    var accountTypes = [AccountsDatum]()
    var accID = 0
    var currencyTypes = ["AED","SAR","QAR","OMR"]
    var currency = ""
    var activeTF:UITextField?
    var gateway = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBActions
    
    
    @IBAction func depositAction(_ sender: Any) {
        
        if let account = tfTradingAccount.text, let currency = tfCurrency.text, let amount = tfAmount.text{
            
            if account.isEmpty{
                self.showAlert(title: "Error", message: "Select account..!", actions: nil)
            }else if currency.isEmpty{
                self.showAlert(title: "Error", message: "Select Currency..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Error", message: "Enter Amount..!", actions: nil)
            }else{
                
                let interPay = PayModel(accountId: accID,gateway: gateway,amount: Int(amount), currency: currency)
                instatPay(pay: interPay)
            }
            
        }
        
    }
    
}

//MARK: - UITextField Delegate
extension InstantTransferVC:UITextFieldDelegate{
    func setupTF(){
        tfTradingAccount.delegate = self
        tfCurrency.delegate = self
        
        tfTradingAccount.inputView = instantPicker
        tfCurrency.inputView = instantPicker
        
        instantPicker.delegate = self
        instantPicker.dataSource = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
    }
}

//MARK: - Picker
extension InstantTransferVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfTradingAccount{
            return accountTypes.count
        }else{
            return currencyTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfTradingAccount{
            return (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
        }else{
            return currencyTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfTradingAccount{
            tfTradingAccount.text = (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
            self.accID = accountTypes[row].id ?? 0
        }else{
            tfCurrency.text = currencyTypes[row]
            self.currency = currencyTypes[row]
        }
    }
    
}

//MARK: - API

extension InstantTransferVC{
    
    func instatPay(pay:PayModel){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .Pay(params: pay.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let payResp:PayResponse = self.handleResponse(data: data as! Data){
                    if payResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Transaction Complete Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: payResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
        
    }
    
}
