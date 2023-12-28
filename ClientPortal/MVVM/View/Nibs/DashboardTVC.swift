//
//  DashboardTVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class DashboardTVC: UITableViewCell {

    @IBOutlet weak var cellView: UIViewX!
    @IBOutlet weak var lblAccNum: UILabel!
    @IBOutlet weak var lblPlateform: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblEquity: UILabel!
    @IBOutlet weak var lblLevrage: UILabel!
    @IBOutlet weak var lblDeposit: UILabel!
    
    var depositCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(data:AccountsDatum){
        lblAccNum.text = "\(data.login ?? 0)"
        lblPlateform.text = data.platform ?? ""
        lblType.text = data.type ?? ""
        lblBalance.text = "$\(data.state?.margin?.balance ?? 0)"
        lblEquity.text = "$\(data.state?.margin?.equity ?? 0)"
        lblLevrage.text = "$\(data.state?.margin?.leverage ?? 0)"
        lblDeposit.text = "Deposit"
    }
    
    @IBAction func depositAction(_ sender: Any) {
        if let callback = depositCallBack{
            callback()
        }
    }
    
    
}
