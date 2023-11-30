//
//  MenuProfileVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class MenuProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func documentsAction(_ sender: Any) {
        let vc = ViewControllers.UserDocsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logsAction(_ sender: Any) {
        let vc = ViewControllers.UserLogsVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
