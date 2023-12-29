//
//  TrainingVideoResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 29/12/2023.
//

import Foundation

// MARK: - TrainingVideosResponse
struct TrainingVideosResponse: Codable {
    var status: Bool?
    var result: TrainingResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct TrainingResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [TrainingDatum]?
}

// MARK: - Datum
struct TrainingDatum: Codable {
    var id: Int?
    var gallery: String?
    var url: String?
    var fileURL: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, gallery, url
        case fileURL = "fileUrl"
        case isActive, isDeleted, createdAt, updatedAt
    }
}
