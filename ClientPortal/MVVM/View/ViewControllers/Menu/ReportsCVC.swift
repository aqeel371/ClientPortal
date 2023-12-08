//
//  ReportsCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class ReportsCVC: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var statusView: UIViewX!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblGateway: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Populate
    func config(status:Bool){
        if status{
            statusView.backgroundColor = UIColor.Green200
            statusLabel.textColor = UIColor.Green700
        }else{
            statusView.backgroundColor = UIColor.Red200
            statusLabel.textColor = UIColor.Red700
        }
    }
    
    func populate(data:TransactionDatum){
        lblType.text = data.type ?? ""
        lblAmount.text = "\(data.amount ?? 0)"
        lblID.text = "\(data.id ?? 0)"
        lblGateway.text = data.gateway ?? ""
        
        if data.type == "INTERNAL_TRANSFER"{
            lblAccount.text = "\(data.accountFromLogin ?? 0)" + " -> " + "\(data.accountToLogin ?? 0)"
        }else{
            lblAccount.text = "\(data.accountLogin ?? 0)"
        }
        
        lblDate.text = (data.createdAt ?? "").formattedDate()
        lblTime.text = (data.createdAt ?? "").formattedTime()
        
        if data.status == .approved{
            config(status: true)
            statusLabel.text = data.status?.rawValue
        }else if data.status == .pending{
            statusView.backgroundColor = UIColor.VividCerulean
            statusLabel.textColor = UIColor.ColorPrimary
            statusLabel.text = data.status?.rawValue
        }else{
            config(status: false)
            statusLabel.text = data.status?.rawValue
        }
    }
    
}
