//
//  TradesCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class TradesCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblAccType: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    @IBOutlet weak var plateFormImage: UIImageView!
    var viewCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func viewAction(_ sender: Any) {
        if let callback = viewCallBack{
            callback()
        }
    }
    
    func populate(data:AccountsDatum){
        lblAccType.text = data.accountTypeTitle ?? ""
        lblType.text = data.platform ?? ""
        lblNumber.text = "\(data.login ?? 0)"
        lblCurrency.text = data.currency ?? ""
        if data.platform == "MT5"{
            balanceLbl.text = data.info?.balance ?? ""
            plateFormImage.image = UIImage(named: "ic_mt5")
        }else{
            balanceLbl.text = "\(data.state?.margin?.balance ?? 0)"
            plateFormImage.image = UIImage(named: "ic_mt4")
        }
    }
}
