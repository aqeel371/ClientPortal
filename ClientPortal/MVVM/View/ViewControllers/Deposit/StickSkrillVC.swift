//
//  StickSkrillVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class StickSkrillVC: UIViewController {

    
    @IBOutlet weak var tfTradingAccount: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tvNotes: UITextView!
    
    //MARK: - Variables
    var spinner :LoadingViewNib?
    var accountPicker = UIPickerView()
    var accountTypes = [AccountsDatum]()
    var accID = 0
    var type:TransferType?
    var gateway = ""
    var currency = "AED"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func depositAction(_ sender: Any) {
        if let account = tfTradingAccount.text, let amount = tfAmount.text, let notes = tvNotes.text{
            
            if account.isEmpty{
                self.showAlert(title: "Error", message: "Select account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Error", message: "Enter Amount..!", actions: nil)
            }else{
                
                let interPay = PayModel(accountId: accID,gateway: gateway,note: notes,amount: Int(amount), currency: currency)
                stickSkrillPay(pay: interPay)
                
            }
            
        }
    }
    

}

//MARK: - UItextView Delegate

extension StickSkrillVC:UITextViewDelegate,UITextFieldDelegate{
    
    func setupTF(){
        tvNotes.delegate = self
        tfTradingAccount.delegate = self
        tfTradingAccount.inputView = accountPicker
        
        accountPicker.delegate = self
        accountPicker.dataSource = self
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.Silver {
            textView.text = nil
            textView.textColor = UIColor.EerieBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Special Notes"
            textView.textColor = UIColor.Silver
        }
    }
}


//MARK: - Picker
extension StickSkrillVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accountTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfTradingAccount.text = (accountTypes[row].platform ?? "") + " - " + "\(accountTypes[row].login ?? 0)"
        accID = accountTypes[row].id ?? 0
    }
    
    
    
}


//MARK: - API

extension StickSkrillVC{
    
    func stickSkrillPay(pay:PayModel){
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
