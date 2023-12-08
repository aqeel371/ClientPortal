//
//  AddBankVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import UIKit

class AddBankVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfHolderName: UITextField!
    @IBOutlet weak var tfBankName: UITextField!
    @IBOutlet weak var tfAccNumber: UITextField!
    @IBOutlet weak var tfSwiftCode: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfIBAN: UITextField!
    @IBOutlet weak var tfCurency: UITextField!
    @IBOutlet weak var tfBankAddress: UITextField!
    
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        
        if let holder = tfHolderName.text, let bank = tfBankName.text, let accNum = tfAccNumber.text , let swift = tfSwiftCode.text, let address = tfAddress.text, let iban = tfIBAN.text, let curr = tfCurency.text,let bankAdd = tfBankAddress.text{
            
            if holder.isEmpty || bank.isEmpty || accNum.isEmpty || swift.isEmpty || address.isEmpty || iban.isEmpty || curr.isEmpty || bankAdd.isEmpty{
                self.showAlert(title: "Error", message: "Enter a Valid Data...!", actions: nil)
            }else{
                
                let bank = BankDatum(accountHolderName: holder,bankName: bank,bankAddress: bankAdd, accountNumber: accNum,swiftCode: swift,address: address,iban: iban,currency: curr)
                self.addBank(b: bank)
            }
            
        }
        
    }
    
}


//MARK: - API
extension AddBankVC{
    
    func addBank(b:BankDatum){
        
        spinner = self.showSpinner()
        
        ApiManager.shared.request(with: .AddBank(params: b.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let bankResp:BanksResponse = self.handleResponse(data: data as! Data){
                    if bankResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(title: "Success", message: "Bank Added Succesfully...!", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: bankResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
        })
        
        
    }
    
}
