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
    var accounts = [AccountsDatum]()
    var spinner :LoadingViewNib?
    var withdraw = ["Bank-Transfer","Crypto"]
    var gateway = ""
    var withdrawAccID = 0
    var transferfromID = 0
    var transferToID = 0
    var depositAccID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        getAccounts()
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
        if let acc = tfDepositAccount.text , let amount = tfDepositAmount.text, let notes = tvDepositNotes.text{
            if acc.isEmpty{
                self.showAlert(title: "Error", message: "Select Account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Erro", message: "Please Enter Amount..!", actions: nil)
            }else{
                
                let deposit = DepositModel(accountId: depositAccID,gateway: "DEPOSIT",note: notes,amount: Int(amount),fee: 0)
                self.depositTransaction(deposit: deposit)
            }
            
        }
        
        
    }
    
    @IBAction func withdrawAction(_ sender: Any) {
        if let method = tfWithdrawMethod.text , let acc = tfWithdrawAcount.text , let amount = tfWithdrawAmount.text, let notes = tvWithdrawNotes.text{
            if method.isEmpty || acc.isEmpty{
                self.showAlert(title: "Error", message: "Select Method and Account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Erro", message: "Please Enter Amount..!", actions: nil)
            }else{
                let withdraw = WithdrawModel(accountId: withdrawAccID,gateway: gateway,note: notes, amount: Int(amount))
                self.withdarwTransaction(withdraw: withdraw)
            }
        }
    }
    
    @IBAction func transferAction(_ sender: Any) {
        if let from = tfTransferAccount.text, let to = tfTransferToAccount.text, let amount = tfTransferAmount.text,let notes = tvTransferNotes.text{
            if from.isEmpty || to.isEmpty{
                self.showAlert(title: "Error", message: "Select Account..!", actions: nil)
            }else if amount.isEmpty{
                self.showAlert(title: "Error", message: "Enter Amount...!", actions: nil)
            }else{
                let data = TransferModel(accountFrom: transferfromID ,accountTo: transferToID,note: notes,amount: Int(amount))
                self.internalTransfer(transfer: data)
            }
        }
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
        
        tfTransferAccount.delegate = self
        tfTransferToAccount.delegate = self
        
        tfDepositAccount.inputView = accountPicker
        tfWithdrawAcount.inputView = accountPicker
        tfWithdrawMethod.inputView = accountPicker
        
        tfTransferAccount.inputView = accountPicker
        tfTransferToAccount.inputView = accountPicker
        
        accountPicker.delegate = self
        accountPicker.dataSource = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
        
        if activeTF == tfWithdrawMethod{
            tfWithdrawMethod.text = withdraw[0]
            self.gateway = withdraw[0]
        }else if activeTF == tfWithdrawAcount{
            tfWithdrawAcount.text = (accounts[0].platform ?? "") + " - " + "\(accounts[0].login ?? 0)"
            self.withdrawAccID = accounts[0].id ?? 0
        }else if activeTF == tfDepositAccount{
            self.depositAccID = accounts[0].id ?? 0
            tfDepositAccount.text = (accounts[0].platform ?? "") + " - " + "\(accounts[0].login ?? 0)"
        }else if activeTF == tfTransferAccount{
            tfTransferAccount.text = (accounts[0].platform ?? "") + " - " + "\(accounts[0].login ?? 0)"
            self.transferToID = accounts[0].id ?? 0
        }else if activeTF == tfTransferToAccount{
            tfTransferToAccount.text = (accounts[0].platform ?? "") + " - " + "\(accounts[0].login ?? 0)"
            self.transferfromID = accounts[0].id ?? 0
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
            return (accounts[row].platform ?? "") + " - " + "\(accounts[row].login ?? 0)"
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfWithdrawMethod{
            tfWithdrawMethod.text = withdraw[row]
            self.gateway = withdraw[row]
        }else if activeTF == tfWithdrawAcount{
            tfWithdrawAcount.text = (accounts[row].platform ?? "") + " - " + "\(accounts[row].login ?? 0)"
            self.withdrawAccID = accounts[row].id ?? 0
        }else if activeTF == tfDepositAccount{
            self.depositAccID = accounts[row].id ?? 0
            tfDepositAccount.text = (accounts[row].platform ?? "") + " - " + "\(accounts[row].login ?? 0)"
        }else if activeTF == tfTransferAccount{
            tfTransferAccount.text = (accounts[row].platform ?? "") + " - " + "\(accounts[row].login ?? 0)"
            self.transferToID = accounts[row].id ?? 0
        }else if activeTF == tfTransferToAccount{
            tfTransferToAccount.text = (accounts[row].platform ?? "") + " - " + "\(accounts[row].login ?? 0)"
            self.transferfromID = accounts[row].id ?? 0
        }
    }
}

//MARK: - API

extension InternalTabsVC{
    
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
                                    self.accounts.append(acc)
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
    
    func internalTransfer(transfer:TransferModel){
        
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .InternalTransfer(params: transfer.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let tranResp:TransferResponse = self.handleResponse(data: data as! Data){
                    if tranResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Transaction Complete Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: tranResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
    func withdarwTransaction(withdraw:WithdrawModel){
        
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .WithrawTransfer(params: withdraw.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let tranResp:TransferResponse = self.handleResponse(data: data as! Data){
                    if tranResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Transaction Complete Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: tranResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
    func depositTransaction(deposit:DepositModel){
        
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Deposit(params: deposit.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let tranResp:TransferResponse = self.handleResponse(data: data as! Data){
                    if tranResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Transaction Complete Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: tranResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}

