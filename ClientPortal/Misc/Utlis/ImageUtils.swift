//
//  ImageUtils.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 05/12/2023.
//

import Foundation
import UIKit
import Kingfisher

class ImageUtil{
    let image:UIImageView!
    func loadImage(url: String? = nil,resource: Resource? = nil, placeholder: UIImage? = nil, name:String? = nil){
        var url = url?.replacingOccurrences(of: "svg", with: "png")
        if let resource = resource{
            self.image.kf.setImage(with: resource, placeholder: placeholder)
        }
        if let url = URL(string: url ?? ""){
            self.image.kf.setImage(with: url, placeholder: placeholder)
        } else {
            if let placeholder = placeholder{
                self.image.image = placeholder
            }
        }
        
    }
    init(image: UIImageView!) {
        self.image = image
    }
}
