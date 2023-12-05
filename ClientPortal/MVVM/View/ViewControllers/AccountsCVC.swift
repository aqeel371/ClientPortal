//
//  AccountsCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class AccountsCVC: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblAccNum: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    
    @IBOutlet weak var lblLevrage: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    
    var fundCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func actionFund(_ sender: Any) {
        if let callback = fundCallBack{
            callback()
        }
    }
    

    //MARK: - Populate
    
    func populate(data:AccountsDatum){
        let acc = (data.platform ?? "") + " - " + ("\(data.login ?? 1)")
        lblAccNum.text = acc
        lblType.text = data.type ?? ""
        
        if data.platform == "MT4"{
            lblAccount.text = "GoDo-Demo"
            lblAccountType.text = (data.accountTypeTitle ?? "") + " Account"
            lblLevrage.text = "1:\(data.state?.leverage ?? 0)"
            
            lblCurrency.text = data.currency ?? ""
            lblBalance.text = "$\(data.state?.margin?.balance ?? 0)"
        }else{
            lblAccount.text = "GoDo-Server"
            lblAccountType.text = (data.accountTypeTitle ?? "") + " Account"
            lblLevrage.text = "1:\(data.info?.leverage ?? "")"
            
            lblCurrency.text = data.currency ?? ""
            lblBalance.text = "$\(data.info?.balance ?? "")"
        }
    }
    
}
