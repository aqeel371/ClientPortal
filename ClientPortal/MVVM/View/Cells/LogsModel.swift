//
//  LogsModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 07/12/2023.
//

import Foundation


// MARK: - LogsResponse
struct LogsResponse: Codable {
    var status: Bool?
    var message: String?
    var result: LogsResult?
    var isSuccess: Bool?
}

// MARK: - Result
struct LogsResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [LogsDatum]?
}

// MARK: - Datum
struct LogsDatum: Codable {
    var id: Int?
    var type: String?
    var onlyCRM: Int?
    var level: String?
    var details, content: Content?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?
    var userID: String?
    var customerID: Int?

    enum CodingKeys: String, CodingKey {
        case id, type
        case onlyCRM = "onlyCrm"
        case level, details, content, isActive, isDeleted, createdAt, updatedAt
        case userID = "userId"
        case customerID = "customerId"
    }
}

// MARK: - Content
struct Content: Codable {
}
