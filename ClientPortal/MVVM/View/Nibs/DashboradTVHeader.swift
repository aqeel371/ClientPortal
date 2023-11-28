//
//  DashboradTVHeader.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import Foundation
import UIKit

class DashboradTVHeader:UIView{
    
    
    class func instanceFromNib() -> DashboradTVHeader {
        
        let view = UINib(nibName: "DashboradTVHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DashboradTVHeader
        
        return view
    }
    
}
