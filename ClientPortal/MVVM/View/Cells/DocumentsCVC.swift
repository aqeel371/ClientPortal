//
//  DocumentsCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import UIKit

class DocumentsCVC: UICollectionViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var statusView: UIViewX!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populate(d:DocsDatum){
        lblTitle.text = d.type ?? ""
        if d.status == .approved{
            lblStatus.text = d.status?.rawValue
            statusView.backgroundColor = UIColor.Green700
        }else if d.status == .pending{
            lblStatus.text = d.status?.rawValue
            statusView.backgroundColor = UIColor.ColorPrimary
        }else{
            lblStatus.text = d.status?.rawValue
            statusView.backgroundColor = UIColor.Red700
        }
        
        dateLbl.text = (d.createdAt ?? "").formattedDate()
        timeLbl.text = (d.createdAt ?? "").formattedTime()
        
    }
}
