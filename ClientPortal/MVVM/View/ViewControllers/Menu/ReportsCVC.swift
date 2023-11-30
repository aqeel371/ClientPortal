//
//  ReportsCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class ReportsCVC: UICollectionViewCell {

    @IBOutlet weak var statusView: UIViewX!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(status:Bool){
        if status{
            statusView.backgroundColor = UIColor.Green200
            statusLabel.textColor = UIColor.Green700
            statusLabel.text = "Confirmed"
        }else{
            statusView.backgroundColor = UIColor.Red200
            statusLabel.textColor = UIColor.Red700
            statusLabel.text = "Cancelled"
        }
    }
    
}
