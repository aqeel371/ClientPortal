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
    var accountTypes = ["A","1","B","2","C","3"]
    var passTypes = ["Main","Investor"]
    var plateformTypes = ["MT4","MT5"]
    var activeTF:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTf()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
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
//        let vc = ViewControllers.ProfileVC.getViewController() as ProfileVC
//        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassAction(_ sender: Any) {
        
        
        
        self.navigationController?.popViewController(animated: true)
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
            return accountTypes[row]
        }else if activeTF == tfPassType{
            return passTypes[row]
        }else{
            return plateformTypes[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfAccounttype{
            tfAccounttype.text = accountTypes[row]
        }else if activeTF == tfPassType{
            tfPassType.text = passTypes[row]
        }else{
            tfPlateformType.text = plateformTypes[row]
        }
    }
}

