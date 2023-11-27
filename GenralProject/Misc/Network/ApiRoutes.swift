//
//  ApiRoutes.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import Alamofire

protocol Router {
    var route : String { get }
    var baseURL : String { get }
    var method : Alamofire.HTTPMethod { get }
    var parameterEncoding : ParameterEncoding { get }
    var header: Alamofire.HTTPHeaders { get }
}
extension API:Router{
    var route: String {
        switch self {
        case .Login:
            return ApiPaths.login
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return ApiConstants.base_url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Login:
            return .post
        default:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self{
        case .Login:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    func jsonParams() -> OptionalDictionary{
        switch self{
        case .Login(let params):
            return params
        default:
            return nil
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        default:
            if let tokken = Global.shared.tokken{
                return ["Authorization":"Bearer \(tokken)"]
            }
            return []
        }
    }
    
    var parameters: OptionalDictionary{
        switch self{
        case .Login:
            return jsonParams()
        default:
            return formateParams()
        }
    }
    
    var url:String{
        switch self {
        default:
            return baseURL + (route.replacingOccurrences(of: "'", with: "%27").replacingOccurrences(of: " ", with: "%20"))
        }
    }
    
}
