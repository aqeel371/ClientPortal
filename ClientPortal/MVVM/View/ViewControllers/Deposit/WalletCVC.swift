//
//  WalletCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import UIKit

class WalletCVC: UICollectionViewCell {

    //MARK: - IBOUtelts
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblNetwork: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Populate
    func populate(w:WalletDatum){
//        lblID.text = "\(w.id ?? 0)"
        lblCurrency.text = w.currency ?? ""
        lblNetwork.text = w.network ?? ""
        lblAddress.text = w.address ?? ""
    }
    
}
