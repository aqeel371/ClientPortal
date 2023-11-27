//
//  ApiConstants.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
internal struct ApiConstants{
    static let base_url = ""
}
internal struct ApiPaths {
    
    //MARK: - Aries Map
    static let login = ""
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
