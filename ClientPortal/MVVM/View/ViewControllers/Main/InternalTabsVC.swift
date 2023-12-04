//
//  InternalTabsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class InternalTabsVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var depositView: UIView!
    @IBOutlet weak var tfDepositAccount: UITextField!
    @IBOutlet weak var tfDepositAmount: UITextField!
    @IBOutlet weak var tvDepositNotes: UITextView!
    
    @IBOutlet weak var withdrawView: UIView!
    @IBOutlet weak var tfWithdrawMethod: UITextField!
    @IBOutlet weak var tfWithdrawAcount: UITextField!
    @IBOutlet weak var tfWithdrawAmount: UITextField!
    @IBOutlet weak var tvWithdrawNotes: UITextView!
    
    @IBOutlet weak var internalTransferView: UIView!
    @IBOutlet weak var tfTransferAccount: UITextField!
    @IBOutlet weak var tfTransferToAccount: UITextField!
    @IBOutlet weak var tfTransferAmount: UITextField!
    @IBOutlet weak var tvTransferNotes: UITextView!
    
    
    //MARK: - Variables
    var typeVc:TabType?
    var activeTF:UITextField?
    var accountPicker = UIPickerView()
    var accounts = ["A","B","C","D","E"]
    var withdraw = ["1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        if typeVc == .deposit{
            lblTitle.text = "Deposit"
            depositView.isHidden = false
            withdrawView.isHidden = true
            internalTransferView.isHidden = true
        }else if typeVc == .withdraw{
            lblTitle.text = "Withdrawal"
            depositView.isHidden = true
            withdrawView.isHidden = false
            internalTransferView.isHidden = true
        }else if typeVc == .transfer{
            lblTitle.text = "Internal Transfer"
            depositView.isHidden = true
            withdrawView.isHidden = true
            internalTransferView.isHidden = false
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func depositAction(_ sender: Any) {
    }
    
    @IBAction func withdrawAction(_ sender: Any) {
    }
    
    @IBAction func transferAction(_ sender: Any) {
    }
    
}

//MARK: - UItextView & UITextFields Methods
extension InternalTabsVC:UITextViewDelegate,UITextFieldDelegate{
    
    func setupTF(){
        
        tfDepositAccount.delegate = self
        tfWithdrawMethod.delegate = self
        tfWithdrawAcount.delegate = self
        
        tvDepositNotes.delegate = self
        tvTransferNotes.delegate = self
        tvWithdrawNotes.delegate = self
        
        tfDepositAccount.inputView = accountPicker
        tfWithdrawAcount.inputView = accountPicker
        tfWithdrawMethod.inputView = accountPicker
        
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
            textView.text = "Special Notes"
            textView.textColor = UIColor.Silver
        }
    }
    
    
}

//MARK: - Picker
extension InternalTabsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfWithdrawMethod{
            return withdraw.count
        }else{
            return accounts.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfWithdrawMethod{
            return withdraw[row]
        }else{
            return accounts[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfWithdrawMethod{
            tfWithdrawMethod.text = withdraw[row]
        }else if activeTF == tfWithdrawAcount{
            tfWithdrawAcount.text = accounts[row]
        }else{
            tfDepositAccount.text = accounts[row]
        }
    }
}
