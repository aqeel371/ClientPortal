//
//  TradeMTView.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/11/2023.
//

import Foundation
import UIKit

class TradeMTView:UIView{
    
    
    @IBOutlet weak var bgView: UIView!
    
    var selectCallBack: (()->Void)? = nil
    var dismissCallBack: (()->Void)? = nil
    
    
    class func instanceFromNib() -> TradeMTView {
        
        let view = UINib(nibName: "TradeMTView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TradeMTView
        view.addTap()
        
        return view
    }
    
    func addTap(){
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss(_:)))
        bgView.addGestureRecognizer(dismissTap)
    }
    
    @objc func handleDismiss(_ sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
        if let callback = dismissCallBack{
            callback()
        }
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
