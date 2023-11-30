//
//  UserDocsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class UserDocsVC: UIViewController {

    @IBOutlet weak var incomView: UIViewX!
    @IBOutlet weak var bankView: UIViewX!
    @IBOutlet weak var additionalView: UIViewX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        incomView.isDottedBorder = true
        bankView.isDottedBorder = true
        additionalView.isDottedBorder = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profielView(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func uploadIncomActio(_ sender: Any) {
    }
    
    @IBAction func uploadBankView(_ sender: Any) {
    }
    
    
    @IBAction func additonalAction(_ sender: Any) {
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func uploadAction(_ sender: Any) {
    }
    
}
