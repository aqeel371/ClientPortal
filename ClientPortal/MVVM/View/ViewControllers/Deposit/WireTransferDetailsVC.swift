//
//  WireTransferDetailsVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class WireTransferDetailsVC: UIViewController {

    //MARK: - IBoutlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleVCLbl: UILabel!
    
    
    //MARK: - Varibles
    var banksData = [BankData]()
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSV()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleVCLbl.text = vcTitle
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
