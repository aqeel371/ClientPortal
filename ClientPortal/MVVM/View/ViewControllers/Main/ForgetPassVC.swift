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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBActions
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetAction(_ sender: Any) {
        
    }
    
}
