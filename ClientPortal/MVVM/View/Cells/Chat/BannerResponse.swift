//
//  BannerResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 05/12/2023.
//

import Foundation

// MARK: - BannerResponse
struct BannerResponse: Codable {
    var status: Bool?
    var result: BannerResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct BannerResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage: Int?
    var pagingCounter: Int?
    var prevPage: Int?
    var data: [BannerDatum]?
}

// MARK: - Datum
struct BannerDatum: Codable {
    var id: Int?
    var title, fileURL, description: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case fileURL = "fileUrl"
        case description, isActive, isDeleted, createdAt, updatedAt
    }
}
