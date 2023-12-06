//
//  ProfileVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfPhoneNum: UITextField!
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    
    //MARK: - Variables
    var spinner:LoadingViewNib?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // Enable swipe to back
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        getProfile()
    }
    
    //MARK: - IBActions
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassAction(_ sender: Any) {
//        let vc = ViewControllers.ChangePasswordVC.getViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func supportAction(_ sender: Any) {
        let vc = ViewControllers.SupportVC.getViewController() as SupportVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API
extension ProfileVC{
    
    func getProfile(){
        spinner = self.showSpinner()
        ApiManager.shared.request(with: .Profile, completion: {resp in
            
            switch resp{
            case .Success(let data):
                if let profileResp:ProfileResponse = self.handleResponse(data: data as! Data){
                    self.spinner?.removeFromSuperview()
                    if profileResp.status ?? false {
                        if let user = profileResp.result{
                            self.handleUser(user: user)
                        }
                    }else{
                        self.showAlert(title: "Error", message: profileResp.message, actions: nil)
                    }
                }
            case .Failure(let error):
                self.spinner?.removeFromSuperview()
                self.handleError(error: error)
            }
        })
    }
    
    func handleUser(user:ProfileResult){
        
        tfFName.text = user.firstName ?? ""
        tfLName.text = user.lastName ?? ""
        tfPhoneNum.text = user.phone ?? ""
        tfCountry.text = (user.country ?? "") + " - " + (user.city ?? "")
        tfAddress.text = user.address ?? ""
        
    }
    
}
