//
//  ChangePasswordVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class ChangePasswordVC: UIViewController {

    //MARK: - IBoutlets
    @IBOutlet weak var tfAccounttype: UITextField!
    @IBOutlet weak var tfPassType: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPass: UITextField!
    @IBOutlet weak var tfPlateformType: UITextField!
    
    
    //MARK: - Variables
    var eyePass = true
    var eyecnpass = true
    var passPicker = UIPickerView()
    var accountTypes = [AccountsDatum]()
    var passTypes = ["main","investor"]
    var plateformTypes = ["MT4","MT5"]
    var activeTF:UITextField?
    var accID:Int?
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTf()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        tfAccounttype.text = "\(accountTypes[0].login ?? 0)"
        self.accID = accountTypes[0].id ?? 0
        
    }
    
    //MARK: - IBActions
    
    @IBAction func passEyeAction(_ sender: UIButton) {
        eyePass = !eyePass
        if eyePass {
            tfPassword.isSecureTextEntry = true
            sender.setImage(UIImage(named: "ic_eyecross"), for: .normal)
            
        } else {
            tfPassword.isSecureTextEntry = false
            sender.setImage(UIImage(named: "ic_eye"), for: .normal)
        }
    }
    
    @IBAction func cnfirmPassEyeAction(_ sender: UIButton) {
        eyecnpass = !eyecnpass
        if eyecnpass {
            tfConfirmPass.isSecureTextEntry = true
            sender.setImage(UIImage(named: "ic_eyecross"), for: .normal)
            
        } else {
            tfConfirmPass.isSecureTextEntry = false
            sender.setImage(UIImage(named: "ic_eye"), for: .normal)
        }
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassAction(_ sender: Any) {
        if let accType = tfAccounttype.text, let passType = tfPassType.text, let newPass = tfPassword.text , let cnPass = tfConfirmPass.text, let plateform = tfPlateformType.text{
            
            if accType.isEmpty{
                self.showAlert(title: "Error", message: "Select Your Account..!", actions: nil)
            }else if passType.isEmpty{
                self.showAlert(title: "Error", message: "Select Password Type..!", actions: nil)
            }else if newPass.isEmpty || newPass.count < 8{
                self.showAlert(title: "Error", message: "Enter a Valid Pass..!", actions: nil)
            }else if cnPass.isEmpty || newPass != cnPass{
                self.showAlert(title: "Error", message: "Password Missmatch..!", actions: nil)
            }else if plateform.isEmpty{
                self.showAlert(title: "Error", message: "Select Your PLateform..!", actions: nil)
            }else{
                let acc = AccChangePassModel(newPassword: newPass,confirmNewPassword: cnPass,type: passType)
                
                changePass(data: acc)
                
            }
        }
    }
}

//MARK: - UITextField Delegate
extension ChangePasswordVC:UITextFieldDelegate{
    func setupTf(){
        tfAccounttype.delegate = self
        tfPassType.delegate = self
        tfPlateformType.delegate = self
        
        tfAccounttype.inputView = passPicker
        tfPassType.inputView = passPicker
        tfPlateformType.inputView = passPicker
        
        passPicker.delegate = self
        passPicker.dataSource = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
        
        if activeTF == tfAccounttype{
            tfAccounttype.text = "\(accountTypes[0].login ?? 1)" + " - " + "\(accountTypes[0].platform ?? "")"
            self.accID = accountTypes[0].id ?? 0
        }else if activeTF == tfPassType{
            tfPassType.text = passTypes[0]
        }else{
            tfPlateformType.text = plateformTypes[0]
        }
    }
}


//MARK: - Picker
extension ChangePasswordVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfAccounttype{
            return accountTypes.count
        }else if activeTF == tfPassType{
            return passTypes.count
        }else{
            return plateformTypes.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfAccounttype{
            return "\(accountTypes[row].login ?? 1)"
        }else if activeTF == tfPassType{
            return passTypes[row]
        }else{
            return plateformTypes[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfAccounttype{
            tfAccounttype.text = "\(accountTypes[row].login ?? 1)" + " - " + "\(accountTypes[row].platform ?? "")"
            self.accID = accountTypes[row].id ?? 0
        }else if activeTF == tfPassType{
            tfPassType.text = passTypes[row]
        }else{
            tfPlateformType.text = plateformTypes[row]
        }
    }
}

//MARK: - API

extension ChangePasswordVC{
    
    func changePass(data:AccChangePassModel){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .AccountChnagePass(id: self.accID ?? 0, parmas: data.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:ChangePassResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Password Change Succesfully...!", actions: [okAction])
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
