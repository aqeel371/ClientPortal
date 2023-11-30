//
//  TradesCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class TradesCVC: UICollectionViewCell {

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
}
