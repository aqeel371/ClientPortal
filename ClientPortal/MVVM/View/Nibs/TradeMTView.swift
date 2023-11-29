//
//  TradeMTView.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import Foundation
import UIKit

class TradeMTView:UIView{
    
    
    var selectCallBack: (()->Void)? = nil
    
    class func instanceFromNib() -> TradeMTView {
        
        let view = UINib(nibName: "TradeMTView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TradeMTView
        
        return view
    }
    
    @IBAction func mt4Action(_ sender: Any) {
        self.removeFromSuperview()
        if let callback = selectCallBack{
            callback()
        }
    }
    
    
    @IBAction func mt5Action(_ sender: Any) {
        self.removeFromSuperview()
        if let callback = selectCallBack{
            callback()
        }
    }
    
}
