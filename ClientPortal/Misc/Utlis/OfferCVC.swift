//
//  OfferCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import UIKit

class OfferCVC: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func populate(banner:BannerDatum){
        let image = ApiConstants.imageURL + (banner.fileURL ?? "")
        bannerImage.load.loadImage(url: image,placeholder: UIImage(named: "ic_placeholder"))
    }
    
}
