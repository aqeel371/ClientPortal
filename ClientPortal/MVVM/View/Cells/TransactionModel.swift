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
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [TransactionDatum]?
}

// MARK: - Datum
struct TransactionDatum: Codable {
    var id: Int?
    var type: String?
    var gateway: String?
    var status: TransactionStatus?
    var reason: String?
    var note: String?
    var amount, paid, fee: Int?
    var currency: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?
    var accountID: Int?
    var accountFrom, createdBy, updatedBy: String?
    var customerID: Int?
    var accountTo, accountFromLogin: String?
    var accountLogin: Int?
    var accountToLogin: String?

    enum CodingKeys: String, CodingKey {
        case id, type, gateway, status, reason, note, amount, paid, fee, currency, isActive, isDeleted, createdAt, updatedAt
        case accountID = "accountId"
        case accountFrom, createdBy, updatedBy
        case customerID = "customerId"
        case accountTo
        case accountFromLogin = "AccountFrom.login"
        case accountLogin = "Account.login"
        case accountToLogin = "AccountTo.login"
    }
}

enum TransactionStatus: String, Codable {
    case approved = "APPROVED"
    case rejected = "REJECTED"
}
