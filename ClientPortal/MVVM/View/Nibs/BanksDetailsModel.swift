//
//  BanksDetailsModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 11/12/2023.
//

import Foundation

struct Banks:Codable{
    var icon:String
    var title :String
    var banksData:[BankData]
    var qrCode:String?
}

struct BankData:Codable{
    var title:String
    var value:String
}
