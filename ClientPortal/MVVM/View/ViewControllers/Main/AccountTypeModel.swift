//
//  AccountTypeModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import Foundation

// MARK: - AccountTypesResponse
struct AccountTypesResponse: Codable {
    var status: Bool?
    var result: AccTypeResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct AccTypeResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [AccTypeDatum]?
}

// MARK: - Datum
struct AccTypeDatum: Codable {
    var id: Int?
    var counter: String?
    var title, groupPath: String?
    var groupPathSwapFree: String?
    var currency, type: String?
    var showInCp, showInCRM, showInIbAgreement, isActive: Int?
    var isDeleted: Int?
    var platform, createdAt, updatedAt: String?
    var createdBy, updatedBy: Int?

    enum CodingKeys: String, CodingKey {
        case id, counter, title, groupPath, groupPathSwapFree, currency, type, showInCp
        case showInCRM = "showInCrm"
        case showInIbAgreement, isActive, isDeleted, platform, createdAt, updatedAt, createdBy, updatedBy
    }
}
