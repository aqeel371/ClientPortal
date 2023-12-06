//
//  BanksCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class BanksCVC: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblIban: UILabel!
    @IBOutlet weak var lblAccNum: UILabel!
    @IBOutlet weak var lblSwiftCode: UILabel!
    @IBOutlet weak var lblBenfName: UILabel!
    @IBOutlet weak var lblBenfAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Populate
    func populate(bank:BankDatum){
        
        lblName.text = bank.bankName ?? ""
        lblAddress.text = bank.bankAddress ?? ""
        lblIban.text = bank.iban ?? ""
        lblAccNum.text = bank.accountNumber ?? ""
        lblSwiftCode.text = bank.swiftCode ?? ""
        lblBenfName.text = bank.accountHolderName ?? ""
        lblBenfAddress.text = bank.address ?? ""
        
        
    }
    
}
