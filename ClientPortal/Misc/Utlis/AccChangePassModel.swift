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
