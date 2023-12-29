//
//  TrainingCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 30/11/2023.
//

import UIKit

class TrainingCVC: UICollectionViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    
    var playCallBack: (()->Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playAction(_ sender: Any) {
        if let callback = playCallBack{
            callback()
        }
    }
    
    func config(train:TrainingDatum){
        let image = ApiConstants.imageURL + (train.fileURL ?? "")
        videoImage.load.loadImage(url: image,placeholder: UIImage(named: "ic_placeholder"))
    }
}
