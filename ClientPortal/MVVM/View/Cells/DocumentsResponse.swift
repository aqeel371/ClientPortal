//
//  DocumentsResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

//MARK: - Upload Docs
struct UploadDocs:Codable{
    var PROOF_OF_ID:Data?
    var PROOF_OF_ADDRESS:Data?
    var SOURCE_OF_INCOME:Data?
    var ADDITIONAL:Data?
}

//MARK: - UploadDocs Response

// MARK: - DocsResponse
struct UploadDocsResponse: Codable {
    var status: Bool?
    var result: [DocsResult]?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - DocumentsResponse
struct DocumentsResponse: Codable {
    var status: Bool?
    var result: DocsResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct DocsResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [DocsDatum]?
}

// MARK: - Datum
struct DocsDatum: Codable {
    var id: Int?
    var type: String?
    var file1: String?
    var file2: String?
    var status: DocStatus?
    var rejectionReason, note: String?
    var isActive, isDeleted: Int?
    var createdAt, updatedAt: String?
    var customerID: Int?
    var createdBy, updatedBy: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, type, file1, file2, status, rejectionReason, note, isActive, isDeleted, createdAt, updatedAt
        case customerID = "customerId"
        case createdBy, updatedBy
    }
}

enum DocStatus: String, Codable {
    case approved = "Approved"
    case pending = "Pending"
    case rejected = "Rejected"
}
