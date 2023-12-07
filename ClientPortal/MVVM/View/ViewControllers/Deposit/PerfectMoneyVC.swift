//
//  PerfectMoneyVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class PerfectMoneyVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfTradingAccount: UITextField!
    @IBOutlet weak var tfPayeeAccount: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tvNotes: UITextView!
    
    //MARK: - Variables
    var spinner:LoadingViewNib?
    var accountPicker = UIPickerView()
    var accountTypes = [AccountsDatum]()
    var accID = 0
    var payeeAccount = ["U35900420 - USD","E3329162 - EUR"]
    var payee = ""
    var activeTF :UITextField?
    var gateway = ""
    var currency = "AED"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func depositAction(_ sender: Any) {
        
        if let account = tfTradingAccount.text, let payee = tfPayeeAccount.text, let amount = tfAmount.text,let notes = tvNotes.text{
            
            if account.isEmpty{
                self.showAlert(title: "Error", message: "Select account..!", actions: nil)
            }else if payee.isEmpty{
                self.showAlert(title: "Error", message: "Enter Payee Account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Error", message: "Enter Amount..!", actions: nil)
            }else{
                
                let interPay = PayModel(accountId: accID,gateway: gateway,note: notes,amount: Int(amount), payeeAccount: payee, currency: currency)
                perfectMoneyPay(pay: interPay)
                
            }
            
        }
        
    }
    

}

//MARK: - UITextView Delegate
extension PerfectMoneyVC:UITextViewDelegate,UITextFieldDelegate{
    
    func setupTF(){
        tvNotes.delegate = self
        tfTradingAccount.delegate = self
        tfPayeeAccount.delegate = self
        tfTradingAccount.inputView = accountPicker
        tfPayeeAccount.inputView = accountPicker
        
        accountPicker.delegate = self
        accountPicker.dataSource = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.Silver {
            textView.text = nil
            textView.textColor = UIColor.EerieBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Notes"
            textView.textColor = UIColor.Silver
        }
    }
}

//MARK: - Picker
extension PerfectMoneyVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfTradingAccount{
            return accountTypes.count
        }else{
            return payeeAccount.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfTradingAccount{
            return (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
        }else{
            return payeeAccount[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfTradingAccount{
            tfTradingAccount.text = (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
            self.accID = accountTypes[row].id ?? 0
        }else{
            tfPayeeAccount.text = payeeAccount[row]
            self.payee = payeeAccount[row]
        }
    }
    
    
    
}


//MARK: - API

extension PerfectMoneyVC{
    
    func perfectMoneyPay(pay:PayModel){
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
