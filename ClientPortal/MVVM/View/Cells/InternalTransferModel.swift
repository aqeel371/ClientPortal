//
//  InternalTransferModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 07/12/2023.
//

import Foundation

struct TransferModel:Codable{
    var accountFrom:Int?
    var accountTo:Int?
    var note:String?
    var amount:Int?
}

struct WithdrawModel:Codable{
    var accountId:Int?
    var gateway:String?
    var note:String?
    var amount:Int?
}

struct DepositModel:Codable{
    var accountId:Int?
    var gateway:String?
    var reason:String?
    var note:String?
    var amount:Int?
    var fee:Int?
}

// MARK: - TransferResponse
struct TransferResponse: Codable {
    var status: Bool?
    var result: TransferResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct TransferResult: Codable {
    var id: Int?
    var updatedAt, createdAt: String?
    var paid: Int?
    var note: String?
    var fee:Int?
    var accountFrom, amount, accountTo: Int?
    var type: String?
    var isDeleted: Bool?
    var customerID: Int?
    var gateway, status: String?
    var isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, updatedAt, createdAt, paid, note, accountFrom, amount, accountTo, type, isDeleted
        case customerID = "customerId"
        case gateway, status, isActive
    }
}
