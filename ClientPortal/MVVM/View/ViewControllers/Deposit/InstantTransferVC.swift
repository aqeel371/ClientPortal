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
    var instantPicker = UIPickerView()
    var accountTypes = ["A","1","B","2","C","3"]
    var currencyTypes = ["X","1","Y","2","Z","3"]
    var activeTF:UITextField?
    
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
                
                self.navigationController?.popViewController(animated: true)
                
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
            return accountTypes[row]
        }else{
            return currencyTypes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfTradingAccount{
            tfTradingAccount.text = accountTypes[row]
        }else{
            tfCurrency.text = currencyTypes[row]
        }
    }
    
}
