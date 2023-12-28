//
//  AddAccountVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import UIKit

class AddAccountVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var vcTitleLbl: UILabel!
    @IBOutlet weak var tfPlateForm: UITextField!
    @IBOutlet weak var tfAccType: UITextField!
    @IBOutlet weak var tfLevrage: UITextField!
    
    //MARK: - Variables
    var picker = UIPickerView()
    var plateforms = ["MT4","MT5"]
    var levrages = ["100","200","300","400"]
    var accTypes = [AccTypeDatum]()
    var mt4Acc = [AccTypeDatum]()
    var mt5Acc = [AccTypeDatum]()
    var activeTF:UITextField?
    var titleVC = ""
    var spinner :LoadingViewNib?
    
    var plateform = "MT4"
    var accTypeId = 0
    var levr = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vcTitleLbl.text = "Open " + titleVC + " Account"
        for acc in accTypes{
            if acc.platform == "MT4"{
                mt4Acc.append(acc)
            }else{
                mt5Acc.append(acc)
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func createAction(_ sender: Any) {
        if let plate = tfPlateForm.text , let type = tfAccType.text,let lev = tfLevrage.text{
            if plate.isEmpty || type.isEmpty || lev.isEmpty{
                self.showAlert(title: "Error", message: "Please Select Data..!", actions: nil)
            }else{
                let acc = AddAccountModel(accountType: type,accountTypeId: accTypeId,leverage: levr, platform: plate)
                addAccount(acc: acc)
                
            }
        }
    }
    

}

//MARK: - UItextField And Picker
extension AddAccountVC:UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    func setupTF(){
        tfPlateForm.delegate = self
        tfAccType.delegate = self
        tfLevrage.delegate = self
        
        picker.delegate = self
        picker.dataSource = self
        
        tfPlateForm.inputView = picker
        tfAccType.inputView = picker
        tfLevrage.inputView = picker
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTF = textField
        
        if activeTF == tfPlateForm{
            activeTF?.text = plateforms[0]
            plateform = plateforms[0]
        }else if activeTF == tfAccType{
            if plateform == "MT4"{
                activeTF?.text = mt4Acc[0].title ?? ""
                accTypeId = mt4Acc[0].id ?? 0
            }else{
                activeTF?.text = mt5Acc[0].title ?? ""
                accTypeId = mt5Acc[0].id ?? 0
            }
        }else{
            activeTF?.text = "1:" + levrages[0]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if activeTF == tfPlateForm{
            return plateforms.count
        }else if activeTF == tfAccType{
            if plateform == "MT4"{
                return mt4Acc.count
            }else{
                return mt5Acc.count
            }
        }else{
            return levrages.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if activeTF == tfPlateForm{
            return plateforms[row]
        }else if activeTF == tfAccType{
            if plateform == "MT4"{
                return mt4Acc[row].title ?? ""
            }else{
                return mt5Acc[row].title ?? ""
            }
        }else{
            return "1:" + levrages[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeTF == tfPlateForm{
            activeTF?.text = plateforms[row]
            plateform = plateforms[row]
        }else if activeTF == tfAccType{
            if plateform == "MT4"{
                activeTF?.text = mt4Acc[row].title ?? ""
                accTypeId = mt4Acc[row].id ?? 0
            }else{
                activeTF?.text = mt5Acc[row].title ?? ""
                accTypeId = mt5Acc[row].id ?? 0
            }
        }else{
            activeTF?.text = "1:" + levrages[row]
            levr = Int(levrages[row]) ?? 0
        }
    }
    
}

//MARK: - API

extension AddAccountVC{
    
    func addAccount(acc:AddAccountModel){
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .AddAccount(parmas: acc.dictionary as [String:AnyObject]?), completion: {
            resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:AccountAddResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Account Added Succesfully...!", actions: [okAction])
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
