//
//  TransferTVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class TransferTVC: UITableViewCell {

    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var nextView: UIViewX!
    @IBOutlet weak var nextIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected{
            nextView.backgroundColor = UIColor.VividCerulean
            nextIcon.tintColor = .white
            bankName.font = UIFont(name: "QuicksandSemiBold", size: 14)
        }else{
            nextView.backgroundColor = UIColor.GhostWhite
            nextIcon.tintColor = UIColor.DarkSilver
            bankName.font = UIFont(name: "QuicksandMedium", size: 14)
        }
        // Configure the view for the selected state
    }
    
}
