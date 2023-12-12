//
//  TransactionModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

// MARK: - TransactionResponse
struct TransactionResponse: Codable {
    var status: Bool?
    var result: TransactionResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct TransactionResult: Codable {
    var prevPage: Int?
    var data: [TransactionDatum]?
    var totalPages, limit, totalDocs: Int?
    var hasNextPage, hasPrevPage: Bool?
    var page: Int?
    var nextPage: Int?
    var pagingCounter: Int?
}

// MARK: - Datum
struct TransactionDatum: Codable {
    var accountFrom, accountTo: Int?
    var isDeleted: Int?
    var accountToLogin, accountFromLogin: Int?
    var status: TransactionStatus?
    var amount: Double?
    var currency: String?
    var isActive, customerID: Int?
    var createdAt, gateway, type, updatedAt: String?
    var paid, id: Int?
    var createdBy, updatedBy: Int?
    var note: String?
    var fee: Int?
    var reason: String?
    var accountLogin, accountID: Int?
    
    enum CodingKeys: String, CodingKey {
        case accountFrom, isDeleted
        case accountToLogin = "AccountTo.login"
        case status, amount, currency, isActive
        case customerID = "customerId"
        case createdAt, gateway, type, updatedAt, paid, id, createdBy, accountTo
        case accountFromLogin = "AccountFrom.login"
        case updatedBy, note, fee, reason
        case accountLogin = "Account.login"
        case accountID = "accountId"
    }
}

enum TransactionStatus: String, Codable {
    case approved = "APPROVED"
    case rejected = "REJECTED"
    case pending = "PENDING"
}
