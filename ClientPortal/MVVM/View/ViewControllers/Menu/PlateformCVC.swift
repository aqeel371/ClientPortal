//
//  PlateformCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class PlateformCVC: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var btn: UIButtonX!
    
    
    
    var downloadCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populate(p:Plateforms){
        title.text = p.title
        btn.setTitle(p.btn, for: .normal)
        if p.title.contains("MT4") {
            icon.image = UIImage(named: "ic_mt4")
        } else {
            icon.image = UIImage(named: "ic_mt5")
        }
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        if let callback = downloadCallBack{
            callback()
        }
    }
    
    
}
