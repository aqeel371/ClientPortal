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
    var accID = 143
    var payeeAccount = ["U35900420 - USD","E3329162 - EUR"]
    var payee = ""
    var activeTF :UITextField?
    var gateway = "perfectmoney"
    var currency = "USD"
    
    
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
        
        if activeTF == tfTradingAccount{
            tfTradingAccount.text = (accountTypes[0].platform ?? "") + " - " + "\(accountTypes[0].login ?? 0)"
            self.accID = accountTypes[0].id ?? 0
        }else{
            tfPayeeAccount.text = payeeAccount[0]
            self.payee = "U35900420"
            self.currency = "USD"
        }
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
            if row == 0{
                self.payee = "U35900420"
                self.currency = "USD"
            }else{
                self.currency = "EUR"
                self.payee = "E3329162"
            }
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
                        
                        let url = URL(string: "https://perfectmoney.com/api/step1.asp")!
                        //                        let urlString = "https://perfectmoney.com/api/step1.asp"
                        let data = [
                            "PAYEE_ACCOUNT": self.payee,
                            "PAYEE_NAME": "GodoFx",
                            "PAYMENT_ID": "\(payResp.result?.id ?? 0)",
                            "PAYMENT_AMOUNT": "\(pay.amount ?? 0)",
                            "PAYMENT_UNITS": payResp.result?.currency ?? "",
                            "PAYMENT_URL": ApiConstants.base_url + ApiPaths.deposit, // Replace with the actual payment URL
                            "NOPAYMENT_URL": ApiConstants.base_url +  ApiPaths.deposit, // Replace with the actual no payment URL
                            "PAYMENT_URL_METHOD": "LINK"
                        ]
                        
//                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.openWindowWithPost(url: url, data: data)
//                        }
//                        self.showAlert(title: "Success", message: "Transaction Complete Succesfully...!", actions: [okAction])
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
    
    func openWindowWithPost(url: URL, data: [String: String]) {
        // Create a form
        var form = URLRequest(url: url)
        form.httpMethod = "POST"
        form.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        form.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Set up the form data
        var bodyString = ""
        for (key, value) in data {
            bodyString += "\(key)=\(value)&"
        }
        form.httpBody = bodyString.data(using: .utf8)
        
        let webVC = WebViewController.loadFromNib()
        webVC.url = ""
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            webVC.webView.load(form)
        })
    }
    
}
