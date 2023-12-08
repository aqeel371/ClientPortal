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
        case .Profile:
            return ApiPaths.profile
        case .Banners:
            return ApiPaths.banner
        case .Accounts:
            return ApiPaths.accounts
        case .AccountChnagePass(let id, _):
            return ApiPaths.accounts + "/\(id)" + ApiPaths.changePass
        case .AccountOpenPosition(let id):
            return ApiPaths.accounts + "/\(id)" + ApiPaths.open
        case .AccountClosePosition(let id):
            return ApiPaths.accounts + "/\(id)" + ApiPaths.close
        case .GetBanks, .AddBank:
            return ApiPaths.banks
        case .GetWallets, .AddWallet:
            return ApiPaths.wallets
        case .GetDocs, .AddDocs:
            return ApiPaths.docs
        case .Transaction:
            return ApiPaths.transaction
        case .InternalTransfer:
            return ApiPaths.internalTransfer
        case .WithrawTransfer:
            return ApiPaths.withdraw
        case .Deposit:
            return ApiPaths.deposit
        case .Pay:
            return ApiPaths.pay
        case .GetLogs:
            return ApiPaths.logs
        case .ProfileChangePassword:
            return ApiPaths.profileChangePass
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
        case .AccountChnagePass:
            return .post
        case .InternalTransfer, .WithrawTransfer, .Deposit, .Pay:
            return .post
        case .AddBank, .AddWallet, .AddDocs:
            return .post
        case .ProfileChangePassword:
            return .post
        default:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self{
        case .Login:
            return JSONEncoding.default
        case .AccountChnagePass:
            return JSONEncoding.default
        case .InternalTransfer, .WithrawTransfer, .Deposit, .Pay:
            return JSONEncoding.default
        case .AddBank, .AddWallet:
            return JSONEncoding.default
        case .ProfileChangePassword:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    func jsonParams() -> OptionalDictionary{
        switch self{
        case .Login(let params):
            return params
        case .AccountChnagePass(_ ,let params):
            return params
        case .InternalTransfer(let params):
            return params
        case .WithrawTransfer(let params):
            return params
        case .Deposit(let params):
            return params
        case .Pay(let params):
            return params
        case .AddBank(let params):
            return params
        case .AddWallet(let params):
            return params
        case .ProfileChangePassword(let params):
            return params
        default:
            return nil
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .Login:
            return []
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
        case .AccountChnagePass:
            return jsonParams()
        case .InternalTransfer, .WithrawTransfer, .Deposit, .Pay:
            return jsonParams()
        case .AddBank, .AddWallet:
            return jsonParams()
        case .ProfileChangePassword:
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
