//
//  BanksResonse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

// MARK: - BanksResponse
struct BanksResponse: Codable {
    var status: Bool?
    var result: BanksResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct BanksResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage: Int?
    var pagingCounter: Int?
    var prevPage: Int?
    var data: [BankDatum]?
}

// MARK: - Datum
struct BankDatum: Codable {
    var id: Int?
    var accountHolderName, bankName, bankAddress, accountNumber: String?
    var swiftCode, address, iban, currency: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?
    var customerID: Int?
    var createdBy, updatedBy: Int?

    enum CodingKeys: String, CodingKey {
        case id, accountHolderName, bankName, bankAddress, accountNumber, swiftCode, address, iban, currency, isActive, isDeleted, createdAt, updatedAt
        case customerID = "customerId"
        case createdBy, updatedBy
    }
}
