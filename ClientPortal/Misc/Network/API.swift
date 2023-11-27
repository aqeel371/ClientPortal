//
//  API.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: - Operators
infix operator =>
infix operator =|
infix operator =/
prefix operator ¿

//MARK: - TypeAlies
typealias OptionalSwiftJSONParameters = [String : JSON]?
typealias OptionalDictionary = [String : AnyObject]?

func =>(key : String, json : OptionalSwiftJSONParameters) -> String{
    return json?[key]?.stringValue ?? ""
}

func =/(key : String, json : OptionalSwiftJSONParameters) -> Int{
    return json?[key]?.int ?? 0
}

func =|(key : String, json : OptionalSwiftJSONParameters) -> String{
    return json?[key]?.stringValue ?? ""
}

prefix func ¿(value : String?) -> AnyObject {
    return value.unwrap() as AnyObject
}

prefix func ~(value : String?) -> String{
    return (value ?? "").replacingOccurrences(of: "\"", with: "")
}

prefix func -(value : String) -> String{
    return NSLocalizedString(value, comment: "")
}

//MARK: - API_BASE
enum API{
    case Login(params:OptionalDictionary)
    
    static func mapKeysAndValues(keys : [String]?, values : [AnyObject]?) -> [String : AnyObject]? {
        guard let tempValues = values,let tempKeys = keys else { return nil}
        var params = [String : AnyObject]()
        for (key,value) in zip(tempKeys,tempValues) {
            params[key] = value
        }
        return params
    }
}
//MARK: - MAP Key Value
extension API{
    func formateParams() -> OptionalDictionary{
        switch self {
        default:
            return nil
        }
    }
}
internal struct ApiParameters{
    
}

//MARK: - Network
extension Optional where Wrapped: StringType {
    func unwrap() -> String {
        return self?.get ?? ""
    }
}
protocol StringType { var get: String { get } }
extension String: StringType { var get: String { return self } }
