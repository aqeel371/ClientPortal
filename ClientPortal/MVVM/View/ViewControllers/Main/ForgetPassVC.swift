//
//  ForgetPassVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class ForgetPassVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBActions
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetAction(_ sender: Any) {
        if let email = tfEmail.text{
            if email.isEmpty || !isValidEmail(email){
                self.showAlert(title: "Error", message: "Enter a valid Email Address...!", actions: nil)
            }else{
                tfEmail.resignFirstResponder()
                self.forgetPass(email: email)
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

//MARK: - API

extension ForgetPassVC{
    
    func forgetPass(email:String){
        
        spinner = self.showSpinner()
        
        let model = ForgetPass(email: email)
        
        ApiManager.shared.request(with: .ForgetPassword(params: model.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let accResp:ForgetPassResponse = self.handleResponse(data: data as! Data){
                    if accResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.dismiss(animated: true)
                        }
                        self.showAlert(title: "Success", message: accResp.message ?? "", actions: [okAction])
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
