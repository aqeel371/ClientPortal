//
//  PayTrnasctionModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 07/12/2023.
//

import Foundation

struct PayModel:Codable{
    var accountId:Int?
    var gateway:String?
    var reason:String?
    var note:String?
    var amount:Int?
    var payeeAccount:String?
    var convertedAmount:Int?
    var currency:String?
}

// MARK: - PayResponse
struct PayResponse: Codable {
    var status: Bool?
    var result: PayResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct PayResult: Codable {
    var id: Int?
    var currency, updatedAt, createdAt, note: String?
    var amount: Double?
    var fee: Double?
    var customerID, accountID: Int?
    var gateway, status: String?
    var paid: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, currency, updatedAt, createdAt, note, amount, fee
        case customerID = "customerId"
        case accountID = "accountId"
        case gateway, status, paid
    }
}
