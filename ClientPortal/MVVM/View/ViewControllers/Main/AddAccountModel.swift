//
//  AddAccountModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 08/12/2023.
//

import Foundation

// MARK: - AddAccountModel
struct AddAccountModel:Codable{
    var accountType:String?
    var accountTypeId:Int?
    var leverage:Int?
    var platform:String?
}

// MARK: - AccountAddResponse
struct AccountAddResponse: Codable {
    var status: Bool?
    var result: AddAccResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct AddAccResult: Codable {
    var isDeleted: Bool?
    var id, customerID, accountTypeID, login: Int?
    var currency, type: String?
    var isActive: Bool?
    var platform, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted, id
        case customerID = "customerId"
        case accountTypeID = "accountTypeId"
        case login, currency, type, isActive, platform, updatedAt, createdAt
    }
}
