//
//  ApiConstants.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
internal struct ApiConstants{
    static let base_url = "https://dev-staging.godofx.com/api/v1/cp/"
//    static let base_url = "https://dev-api.godofx.com/api/v1/cp/"
    static let imageURL = "https://dev-staging.godofx.com/"
}
internal struct ApiPaths {
    
    //MARK: - Aries Map
    static let login = "auth/login"
    static let profile = "auth/profile"
    static let profileChangePass = "my/change-password"
    static let forgetPass = "auth/send-change-password-otp"
    static let banner = "banners"
    static let accounts = "accounts"
    static let accounttypes = "account-types"
    static let changePass = "/change-password"
    static let close = "/close-positions"
    static let open = "/open-positions"
    static let banks = "bank-accounts"
    static let wallets = "wallets"
    static let docs = "documents"
    static let transaction = "transactions"
    static let internalTransfer = "transactions/internal-transfer"
    static let withdraw = "transactions/withdrawal"
    static let deposit = "transactions/deposit"
    static let pay = "transactions/pay"
    static let logs = "my/activities"
    
}

internal struct GetTransactionKey{
    static let type = "type"
    static let start = "dateFrom"
    static let end = "dateTo"
}

extension Encodable {
    var string: String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    var escapedString: String? {
        let encoder = JSONEncoder()
        if #available(iOS 13.0, *) {
            encoder.outputFormatting = .withoutEscapingSlashes
        } else {
            encoder.outputFormatting = .sortedKeys
        }
        encoder.nonConformingFloatEncodingStrategy = .throw
        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Failed to encode object to JSON: \(error)")
            return nil
        }
    }
    var unEscapedString: String?{
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? String(data: data, encoding: .utf8)?.data(using: .utf8)?.decode(String.self)
    }
    var unEscapedDouble: Double?{
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? String(data: data, encoding: .utf8)?.data(using: .utf8)?.decode(Double.self)
    }
}

extension Data {
    func decode<T:Decodable>(_ type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: self) else {
            throw DecodeError.ErrorWhileDecoding
        }
        return loaded
    }
}
