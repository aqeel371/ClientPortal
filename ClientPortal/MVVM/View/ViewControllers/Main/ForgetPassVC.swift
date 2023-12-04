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
        if let email = tfEmail.text{
            if email.isEmpty || !isValidEmail(email){
                self.showAlert(title: "Error", message: "Enter a valid Email Address...!", actions: nil)
            }else{
                self.dismiss(animated: true)
            }
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
