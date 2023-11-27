//
//  ApiManager.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import Alamofire
typealias APICompletion = (Response) -> ()

class ApiManager{
    static let shared = ApiManager()
    private lazy var client: NetworkClient = NetworkClient()
    @discardableResult
    func request(with api:API,isJsonRequest:Bool = true,isDataRequest:Bool = false,isMultipart:Bool = false,fileArray:[String:Data]? = nil ,completion: @escaping APICompletion) -> DataRequest{
        let request = self.client.request(with: api,isJsonRequest: isJsonRequest, isDataRequest: isDataRequest,isMultipart: isMultipart,fileArray: fileArray, success: { (data) in
            completion(.Success(data))
        }) { (error) in
            completion(.Failure(error))
        }
        return request
    }
}

enum Response {
    case Success(AnyObject?)
    case Failure(NSError?)
}

enum DecodeError: Error {
    case ErrorWhileDecoding
}
