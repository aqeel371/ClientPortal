//
//  AddWalletVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import UIKit

class AddWalletVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfNetWork: UITextField!
    @IBOutlet weak var tfCurrency: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    //MARK: - varibles
    var spinner:LoadingViewNib?
    var picker = UIPickerView()
    var networks = ["USD Coin (USDC) | TRC20","Tether (USDT) | TRC20"]
    var currency = ["USDC","USDT"]
    var activeTF:UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTf()
        // Do any additional setup after loading the view.
    }
    //MARK: IBActions
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        if let network = tfNetWork.text, let curr = tfCurrency.text, let address = tfAddress.text{
            
            if network.isEmpty || curr.isEmpty || address.isEmpty{
                self.showAlert(title: "Error", message: "Eneter A Valid Data", actions: nil)
            }else{
                
                let wallet = WalletDatum(currency: curr,network: network,address: address)
                self.addWallet(w: wallet)
                
            }
            
        }
        
    }
    
}

//MARK: - API
extension AddWalletVC{
    
    func addWallet(w:WalletDatum){
        
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .AddWallet(params: w.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let wallResp:WalletsResponse = self.handleResponse(data: data as! Data){
                    if wallResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Wallet Added Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: wallResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
    }
    
}

//MARK: - Picker Methods

extension AddWalletVC:UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfNetWork{
            return networks.count
        }else{
            return currency.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfNetWork{
            return networks[row]
        }else{
            return currency[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfNetWork{
            tfNetWork.text = networks[row]
        }else{
            tfCurrency.text = currency[row]
        }
    }
    
    
    func setupTf(){
        tfNetWork.delegate = self
        tfCurrency.delegate = self
        
        tfNetWork.inputView = picker
        tfCurrency.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
    }
    
}
