//
//  LoginModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 05/12/2023.
//

import Foundation

struct LoginModel:Codable{
    var email:String?
    var password:String?
}


// MARK: - LoginResponse
struct LoginResponse: Codable {
    var status: Bool?
    var message: String?
    var result: LoginResult?
    var isSuccess: Bool?
}

// MARK: - Result
struct LoginResult: Codable {
    var token: String?
}
