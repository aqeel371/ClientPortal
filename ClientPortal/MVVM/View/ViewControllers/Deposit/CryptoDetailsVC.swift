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
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleVClbl: UILabel!
    
    //MARK: - Variables
    var banksData = [BankData]()
    var qr = ""
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSV()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        titleVClbl.text = vcTitle
    }
    
    
    //MARK: - IBActions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let vc = ViewControllers.ProfileVC.getViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - StackView
    func handleSV(){
        
        qrIcon.image = UIImage(named: qr)
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        for b in banksData{
            let view = BanksNibView.instanceFromNib()
            view.titleLbl.text = b.title
            view.valueLbl.text = b.value
            
            stackView.addArrangedSubview(view)
        }
        
    }

}
