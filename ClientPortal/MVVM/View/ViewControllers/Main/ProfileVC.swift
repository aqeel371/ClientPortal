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
    
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changePassAction(_ sender: Any) {
        let vc = ViewControllers.ChangePasswordVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func supportAction(_ sender: Any) {
    }
}
