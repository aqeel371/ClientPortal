//
//  NetworkClient.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias Success = (AnyObject?) -> ()
typealias Failure = (NSError) -> ()

//MARK: - Network Request
class NetworkClient{
    open func request(with api:API,isJsonRequest:Bool = true, isDataRequest:Bool = false ,isMultipart:Bool = false,fileArray:[String:Data]? = nil ,success: @escaping Success, failure: @escaping Failure) -> DataRequest{
        URLCache.shared.removeAllCachedResponses()
        let params = api.parameters
        let url = api.url
        let method = api.method
        let header = api.header
        let encoding = api.parameterEncoding
        AF.session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        if isMultipart{
            let request = AF.upload(multipartFormData: { multipartFormData in
                if let _ = params{
                    for (key,value) in params.unsafelyUnwrapped{
                        multipartFormData.append((value as? String ?? "").data(using: .utf8) ?? Data(), withName: key)
                    }
                }
                if let files = fileArray{
                    for(key,value) in files{
                        var value = value
                        if let img = UIImage(data: value){
                            value = img.jpegData(compressionQuality: 0.2) ?? Data()
                        }
                        multipartFormData.append(value, withName: key, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/jpeg")
                    }
                }
            }, to: url,headers: header).responseJSON(completionHandler: {
                (Response:AFDataResponse<Any>) in
                switch(Response.result){
                case .success(let data):
                    _ = self.jsonToString(json: data as AnyObject,api: api)
                    success(Response.data as AnyObject)
                case .failure(let error):
                    failure(error as NSError)
                }
            })
            return request
        }
        if isDataRequest{
//            print("Tile: - \(url)")
            let request = AF.request(url,method: method, parameters: params, encoding: encoding, headers: header).responseData(completionHandler: {
                (Response:AFDataResponse<Data>) in
                switch(Response.result){
                case .success(let data):
                    success(data as AnyObject)
                case .failure(let error):
                    failure(error as NSError)
                }
            })
            return request
        } else if isJsonRequest{
            let request = AF.request(url, method: method, parameters: params, encoding: encoding, headers: header).responseJSON {
                (Response:AFDataResponse<Any>) in
                switch(Response.result){
                case .success(let data):
                    _ = self.jsonToString(json: data as AnyObject,api: api)
                    success(Response.data as AnyObject)
                case .failure(let error):
                    failure(error as NSError)
                    print("Error:::::")
                    print("\(api) -> \(api.url)")
                    print(error)
                    print("-----------")
                }
            }
            return request
        } else{
            let request = AF.request(url, method: method, parameters: params, encoding: encoding, headers: header).responseString(completionHandler: {res in
                switch (res.result){
                case .success(let data):
//                    _ = self.jsonToString(json: data as AnyObject,api: api)
                    if res.response?.statusCode == 200{
                        success(data as AnyObject)
                    } else {
                        failure(NSError(domain: "Invalid", code: 404))
                    }
                case .failure(let error):
                    print("\(api.url) -> \(error)")
                    failure(error as NSError)
                }
            })
            return request
        }
    }
    func jsonToString(json: AnyObject,api:API) -> String?{
        switch api {
        default:
            var convertedString:String? = ""
            do {
                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                convertedString = String(data: data1, encoding: String.Encoding.utf8)
            } catch let myJSONError {
                print(myJSONError)
            }
            return convertedString
        }
    }
}
