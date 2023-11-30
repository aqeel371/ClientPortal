//
//  CryptoDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class CryptoDetailsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var networkLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var qrIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
