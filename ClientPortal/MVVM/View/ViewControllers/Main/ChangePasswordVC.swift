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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
