//
//  WalletsResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

// MARK: - WalletsResponse
struct WalletsResponse: Codable {
    var status: Bool?
    var result: WalletResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct WalletResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage: Int?
    var pagingCounter: Int?
    var prevPage: Int?
    var data: [WalletDatum]?
}

// MARK: - Datum
struct WalletDatum: Codable {
    var id: Int?
    var currency, network, note, address: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?
    var customerID: Int?
    var createdBy, updatedBy: Int?

    enum CodingKeys: String, CodingKey {
        case id, currency, network, note, address, isActive, isDeleted, createdAt, updatedAt
        case customerID = "customerId"
        case createdBy, updatedBy
    }
}
