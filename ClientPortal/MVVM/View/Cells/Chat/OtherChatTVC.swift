//
//  OtherChatTVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class OtherChatTVC: UITableViewCell {
    @IBOutlet weak var chatView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatView.layer.cornerRadius = 25
        chatView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
