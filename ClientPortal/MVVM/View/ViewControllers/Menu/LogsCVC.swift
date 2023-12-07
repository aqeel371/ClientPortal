//
//  LogsCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class LogsCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblLogId: UILabel!
    @IBOutlet weak var lblLogtype: UILabel!
    @IBOutlet weak var lblLogDate: UILabel!
    @IBOutlet weak var lblLogTime: UILabel!
    
    var viewCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populate(log:LogsDatum){
        lblLogId.text = "\(log.id ?? 0)"
        lblLogtype.text = log.type ?? ""
        lblLogDate.text = (log.createdAt ?? "").formattedDate()
        lblLogTime.text = (log.createdAt ?? "").formattedTime()
    }
    
    @IBAction func viewAction(_ sender: Any) {
        if let callback = viewCallBack{
            callback()
        }
    }
}
