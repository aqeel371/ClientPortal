//
//  PositionResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 06/12/2023.
//

import Foundation

// MARK: - OpenPositionResponse
struct OpenPositionResponse: Codable {
    var status: Bool?
    var result: OpenPositionResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct OpenPositionResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage: String?
    var pagingCounter: Int?
    var prevPage: String?
    var data: [OpenPositionDatum]?
}

// MARK: - Datum
struct OpenPositionDatum: Codable {
    var position, externalID, login, dealer: String?
    var symbol, action, digits, digitsCurrency: String?
    var reason, contractSize, timeCreate, timeUpdate: String?
    var timeCreateMsc, timeUpdateMsc, modifyFlags, priceOpen: String?
    var priceCurrent, priceSL, priceTP, volume: String?
    var volumeEXT, profit, storage, rateProfit: String?
    var rateMargin, expertID, expertPositionID, comment: String?
    var activationMode, activationTime, activationPrice, activationFlags: String?
    var apiData: [APIDatum]?

    enum CodingKeys: String, CodingKey {
        case position = "Position"
        case externalID = "ExternalID"
        case login = "Login"
        case dealer = "Dealer"
        case symbol = "Symbol"
        case action = "Action"
        case digits = "Digits"
        case digitsCurrency = "DigitsCurrency"
        case reason = "Reason"
        case contractSize = "ContractSize"
        case timeCreate = "TimeCreate"
        case timeUpdate = "TimeUpdate"
        case timeCreateMsc = "TimeCreateMsc"
        case timeUpdateMsc = "TimeUpdateMsc"
        case modifyFlags = "ModifyFlags"
        case priceOpen = "PriceOpen"
        case priceCurrent = "PriceCurrent"
        case priceSL = "PriceSL"
        case priceTP = "PriceTP"
        case volume = "Volume"
        case volumeEXT = "VolumeExt"
        case profit = "Profit"
        case storage = "Storage"
        case rateProfit = "RateProfit"
        case rateMargin = "RateMargin"
        case expertID = "ExpertID"
        case expertPositionID = "ExpertPositionID"
        case comment = "Comment"
        case activationMode = "ActivationMode"
        case activationTime = "ActivationTime"
        case activationPrice = "ActivationPrice"
        case activationFlags = "ActivationFlags"
        case apiData = "ApiData"
    }
}




// MARK: - ClosePositionResponse
struct ClosePositionResponse: Codable {
    var status: Bool?
    var result: ClosePositionResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct ClosePositionResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage: String?
    var pagingCounter: Int?
    var prevPage: String?
    var data: [ClosePositionDatum]?
}

// MARK: - Datum
struct ClosePositionDatum: Codable {
    var deal, externalID, login, dealer: String?
    var order, action, entry, reason: String?
    var digits, digitsCurrency, contractSize, time: String?
    var timeMsc, symbol, price, volume: String?
    var volumeEXT, profit, storage, commission: String?
    var fee, rateProfit, rateMargin, expertID: String?
    var positionID, comment, profitRaw, pricePosition: String?
    var priceSL, priceTP, volumeClosed, volumeClosedEXT: String?
    var tickValue, tickSize, flags, gateway: String?
    var priceGateway, modifyFlags, value: String?
    var apiData: [APIDatum]?
    var marketBid, marketAsk, marketLast: String?

    enum CodingKeys: String, CodingKey {
        case deal = "Deal"
        case externalID = "ExternalID"
        case login = "Login"
        case dealer = "Dealer"
        case order = "Order"
        case action = "Action"
        case entry = "Entry"
        case reason = "Reason"
        case digits = "Digits"
        case digitsCurrency = "DigitsCurrency"
        case contractSize = "ContractSize"
        case time = "Time"
        case timeMsc = "TimeMsc"
        case symbol = "Symbol"
        case price = "Price"
        case volume = "Volume"
        case volumeEXT = "VolumeExt"
        case profit = "Profit"
        case storage = "Storage"
        case commission = "Commission"
        case fee = "Fee"
        case rateProfit = "RateProfit"
        case rateMargin = "RateMargin"
        case expertID = "ExpertID"
        case positionID = "PositionID"
        case comment = "Comment"
        case profitRaw = "ProfitRaw"
        case pricePosition = "PricePosition"
        case priceSL = "PriceSL"
        case priceTP = "PriceTP"
        case volumeClosed = "VolumeClosed"
        case volumeClosedEXT = "VolumeClosedExt"
        case tickValue = "TickValue"
        case tickSize = "TickSize"
        case flags = "Flags"
        case gateway = "Gateway"
        case priceGateway = "PriceGateway"
        case modifyFlags = "ModifyFlags"
        case value = "Value"
        case apiData = "ApiData"
        case marketBid = "MarketBid"
        case marketAsk = "MarketAsk"
        case marketLast = "MarketLast"
    }
}
