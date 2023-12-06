//
//  TradesDetailCVC.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import UIKit

class TradesDetailCVC: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblTicket: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDealType: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblPriceSl: UILabel!
    @IBOutlet weak var lblPriceTp: UILabel!
    @IBOutlet weak var lblCurPrice: UILabel!
    @IBOutlet weak var lblProfit: UILabel!
    
    var type = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Populate
    
    func populateOpen(data:OpenPositionDatum){
        lblTitle.text = type + (data.login ?? "")
        lblSymbol.text = data.symbol ?? ""
        lblTicket.text = data.position ?? ""
        lblTime.text = (data.timeCreate ?? "").convertToFormattedDateString()
        lblDealType.text = "BUY"
        lblVolume.text = data.volume ?? "0"
        lblPriceSl.text = data.priceSL ?? "0.000"
        lblPriceTp.text = data.priceTP ?? "0.000"
        lblCurPrice.text = data.priceCurrent ?? "0.000"
        lblProfit.text = data.profit ?? "0.00"
        
    }
    
    func populateClose(data:ClosePositionDatum){
        lblTitle.text = type + (data.login ?? "")
        lblSymbol.text = data.symbol ?? ""
        lblTicket.text = data.deal ?? ""
        lblTime.text = (data.time ?? "").convertToFormattedDateString()
        lblDealType.text = "BUY"
        lblVolume.text = data.volume ?? "0"
        lblPriceSl.text = data.priceSL ?? "0.000"
        lblPriceTp.text = data.priceTP ?? "0.000"
        lblCurPrice.text = data.pricePosition ?? "0.000"
        lblProfit.text = data.profit ?? "0.00"
        
    }
}
