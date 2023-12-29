//
//  BankNibView.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 11/12/2023.
//

import Foundation
import UIKit

class BanksNibView:UIView{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    var copyCallBack: (()->Void)? = nil
    
    class func instanceFromNib() -> BanksNibView {
        
        let view = UINib(nibName: "BanksNibView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BanksNibView
        
        return view
    }
    
    @IBAction func copyAction(_ sender: Any) {
        if let callback = copyCallBack{
            callback()
        }
    }
    
}
