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
    var accountPicker = UIPickerView()
    var accountTypes = ["A","1","B","2","C","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func depositAction(_ sender: Any) {
        
        if let account = tfTradingAccount.text, let payee = tfPayeeAccount.text, let amount = tfAmount.text{
            
            if account.isEmpty{
                self.showAlert(title: "Error", message: "Select account..!", actions: nil)
            }else if payee.isEmpty{
                self.showAlert(title: "Error", message: "Enter Payee Account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Error", message: "Enter Amount..!", actions: nil)
            }else{
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
    }
    

}

//MARK: - UITextView Delegate
extension PerfectMoneyVC:UITextViewDelegate,UITextFieldDelegate{
    
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
        return accountTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accountTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfTradingAccount.text = accountTypes[row]
    }
    
    
    
}
