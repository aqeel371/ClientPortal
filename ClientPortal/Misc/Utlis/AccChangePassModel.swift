//
//  AccChangePassModel.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

struct AccChangePassModel:Codable{
    var newPassword:String?
    var confirmNewPassword:String?
    var type:String?
}

struct ChangePassResponse:Codable{
    var status,result,isSuccess:Bool?
    var message :String?
}

struct ForgetPass:Codable{
    var email:String?
}

struct ForgetPassResponse:Codable{
    var code: Int?
    var result:ResultPass?
    var message: String?
    var isSuccess, isError,status: Bool?
}

struct ResultPass:Codable{
    
}
