//
//  LoadingViewNib.swift
//  SocialTrader
//
//  Created by Muhammad Aqeel on 23/06/2023.
//

import Foundation
import UIKit

class LoadingViewNib:UIView{
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    class func instanceFromNib() -> LoadingViewNib {
        
        let view = UINib(nibName: "LoadingViewNib", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingViewNib
        if #available(iOS 13.0, *) {
            view.loadingIndicator.style = .large
        }
        view.loadingIndicator.tintColor = .white
        return view
    }
    
    
    func showSpinner() {
        loadingIndicator.startAnimating()
        loadingView.isHidden = false
        self.removeFromSuperview()
    }

    func hideSpinner() {
        loadingIndicator.stopAnimating()
        loadingView.isHidden = true
        self.removeFromSuperview()
    }
    
}
