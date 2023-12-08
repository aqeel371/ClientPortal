//
//  ProfileChangePassVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import UIKit

class ProfileChangePassVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tfCurrPass: UITextField!
    @IBOutlet weak var tfNewPass: UITextField!
    @IBOutlet weak var tfCnfrmPass: UITextField!
    
    //MARK: Varibles
    var spinner:LoadingViewNib?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - IBAction

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func changeAction(_ sender: Any) {
        
        if let curr = tfCurrPass.text , let new = tfNewPass.text, let cnpass = tfCnfrmPass.text{
            
            if curr.isEmpty || new.isEmpty || cnpass.isEmpty{
                self.showAlert(title: "Error", message: "Enter A Valid Data..!", actions: nil)
            }else if new != cnpass{
                self.showAlert(title: "Error", message: "Password mismatch..!", actions: nil)
            }else{
                let model = PasswordModel(currentPassword: curr,newPassword: new,confirmNewPassword: cnpass)
                self.changePassword(model: model)
            }
        }
    }
    
    
}

//MARK: API
extension ProfileChangePassVC{
    
    func changePassword(model:PasswordModel){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .ProfileChangePassword(params: model.dictionary as [String:AnyObject]?), completion: {resp in
            
            switch resp{
            case .Success(let data):
                self.spinner?.removeFromSuperview()
                if let profResp:PassChnageResponse = self.handleResponse(data: data as! Data){
                    if profResp.status ?? false {
                        let okAction = UIAlertAction(title: "Okay", style: .cancel){ _ in
                            self.dismiss(animated: true)
                        }
                        self.showAlert(title: "", message: profResp.message ?? "", actions: [okAction])
                    }else{
                        self.showAlert(title: "Error", message: profResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
            
            
        })
        
    }
    
}
