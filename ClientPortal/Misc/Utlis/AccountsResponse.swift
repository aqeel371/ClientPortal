//
//  AccountsResponse.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 05/12/2023.
//

import Foundation

// MARK: - AccountsResponse
struct AccountsResponse: Codable {
    var status: Bool?
    var result: AccountsResult?
    var isSuccess: Bool?
    var message:String?
}

// MARK: - Result
struct AccountsResult: Codable {
    var page, limit, totalDocs, totalPages: Int?
    var hasNextPage, hasPrevPage: Bool?
    var nextPage, pagingCounter, prevPage: Int?
    var data: [AccountsDatum]?
}

// MARK: - Datum
struct AccountsDatum: Codable {
    var id, login: Int?
    var currency, type: String?
    var isActive, isDeleted: Int?
    var platform, createdAt, updatedAt: String?
    var accountTypeID: Int?
    var createdBy, updatedBy: String?
    var customerID: Int?
    var accountTypeTitle, accountTypeType, accountTypeGroupPath: String?
    var accountTypeGroupInfoID: Int?
    var accountTypeGroupInfoStopOut: String?
    var state: AccountState?
    var info:Info?
//    var rights: [String: Bool]?
    var transactions: AccountTransactions?

    enum CodingKeys: String, CodingKey {
        case id, login, currency, type, isActive, isDeleted, platform, createdAt, updatedAt
        case accountTypeID = "accountTypeId"
        case createdBy, updatedBy
        case customerID = "customerId"
        case accountTypeTitle = "AccountType.title"
        case accountTypeType = "AccountType.type"
        case accountTypeGroupPath = "AccountType.groupPath"
        case accountTypeGroupInfoID = "AccountType.groupInfo.id"
        case accountTypeGroupInfoStopOut = "AccountType.groupInfo.stop_out"
        case state
        case transactions
        case info
//        case rights
    }
}

// MARK: - State
struct AccountState: Codable {
    var address: String?
    var agentAccount: Int?
    var city, comment, country, email: String?
    var enableChangePassword, enabled: Int?
    var group: String?
    var idNumber: Int?
    var leadSource: String?
    var leverage, login: Int?
    var margin: Margin?
    var name, password, passwordInvestor, phone: String?
    var phonePassword: String?
    var readOnly, regDate: Int?
    var regDateStr: String?
    var sendReports: Int?
    var state, status, zipcode: String?

    enum CodingKeys: String, CodingKey {
        case address
        case agentAccount = "agent_account"
        case city, comment, country, email
        case enableChangePassword = "enable_change_password"
        case enabled, group
        case idNumber = "id_number"
        case leadSource = "lead_source"
        case leverage, login, margin, name, password
        case passwordInvestor = "password_investor"
        case phone
        case phonePassword = "phone_password"
        case readOnly = "read_only"
        case regDate = "reg_date"
        case regDateStr = "reg_date_str"
        case sendReports = "send_reports"
        case state, status, zipcode
    }
}

// MARK: - Margin
struct Margin: Codable {
    var balance, equity: Int?
    var group: String?
    var levelType, leverage, margin, marginFree: Int?
    var marginLevel, marginType, volume: Int?

    enum CodingKeys: String, CodingKey {
        case balance, equity, group
        case levelType = "level_type"
        case leverage, margin
        case marginFree = "margin_free"
        case marginLevel = "margin_level"
        case marginType = "margin_type"
        case volume
    }
}

// MARK: - Transactions
struct AccountTransactions: Codable {
    var accountId: Int?
    var totalWithdrawals: MixType?
    var totalDeposits: MixType?
}

// MARK: - Info
struct Info: Codable {
    var login, group, certSerialNumber, rights: String?
    var mqid, registration, lastAccess, lastPassChange: String?
    var lastIP, name, firstName, lastName: String?
    var middleName, company, account, country: String?
    var language, clientID, city, state: String?
    var zipCode, address, phone, email: String?
    var id, status, comment, color: String?
    var phonePassword, leverage, agent, limitPositions: String?
    var limitOrders, currencyDigits, balance, credit: String?
    var interestRate, commissionDaily, commissionMonthly, commissionAgentDaily: String?
    var commissionAgentMonthly, balancePrevDay, balancePrevMonth, equityPrevDay: String?
    var equityPrevMonth, tradeAccounts: String?
    var apiData: [APIDatum]?
    var leadCampaign, leadSource: String?

    enum CodingKeys: String, CodingKey {
        case login = "Login"
        case group = "Group"
        case certSerialNumber = "CertSerialNumber"
        case rights = "Rights"
        case mqid = "MQID"
        case registration = "Registration"
        case lastAccess = "LastAccess"
        case lastPassChange = "LastPassChange"
        case lastIP = "LastIP"
        case name = "Name"
        case firstName = "FirstName"
        case lastName = "LastName"
        case middleName = "MiddleName"
        case company = "Company"
        case account = "Account"
        case country = "Country"
        case language = "Language"
        case clientID = "ClientID"
        case city = "City"
        case state = "State"
        case zipCode = "ZipCode"
        case address = "Address"
        case phone = "Phone"
        case email = "Email"
        case id = "ID"
        case status = "Status"
        case comment = "Comment"
        case color = "Color"
        case phonePassword = "PhonePassword"
        case leverage = "Leverage"
        case agent = "Agent"
        case limitPositions = "LimitPositions"
        case limitOrders = "LimitOrders"
        case currencyDigits = "CurrencyDigits"
        case balance = "Balance"
        case credit = "Credit"
        case interestRate = "InterestRate"
        case commissionDaily = "CommissionDaily"
        case commissionMonthly = "CommissionMonthly"
        case commissionAgentDaily = "CommissionAgentDaily"
        case commissionAgentMonthly = "CommissionAgentMonthly"
        case balancePrevDay = "BalancePrevDay"
        case balancePrevMonth = "BalancePrevMonth"
        case equityPrevDay = "EquityPrevDay"
        case equityPrevMonth = "EquityPrevMonth"
        case tradeAccounts = "TradeAccounts"
        case apiData = "ApiData"
        case leadCampaign = "LeadCampaign"
        case leadSource = "LeadSource"
    }
}

// MARK: - APIDatum
struct APIDatum: Codable {
    var appID, id, valueInt, valueUInt: String?
    var valueDouble: String?

    enum CodingKeys: String, CodingKey {
        case appID = "AppID"
        case id = "ID"
        case valueInt = "ValueInt"
        case valueUInt = "ValueUInt"
        case valueDouble = "ValueDouble"
    }
}

// MARK: - State
struct State: Codable {
    var login, currencyDigits, balance, credit: String?
    var margin, marginFree, marginLevel, marginLeverage: String?
    var profit, storage, floating, equity: String?
    var soActivation, soTime, soLevel, soEquity: String?
    var soMargin, assets, liabilities, blockedCommission: String?
    var blockedProfit, marginInitial, marginMaintenance: String?

    enum CodingKeys: String, CodingKey {
        case login = "Login"
        case currencyDigits = "CurrencyDigits"
        case balance = "Balance"
        case credit = "Credit"
        case margin = "Margin"
        case marginFree = "MarginFree"
        case marginLevel = "MarginLevel"
        case marginLeverage = "MarginLeverage"
        case profit = "Profit"
        case storage = "Storage"
        case floating = "Floating"
        case equity = "Equity"
        case soActivation = "SOActivation"
        case soTime = "SOTime"
        case soLevel = "SOLevel"
        case soEquity = "SOEquity"
        case soMargin = "SOMargin"
        case assets = "Assets"
        case liabilities = "Liabilities"
        case blockedCommission = "BlockedCommission"
        case blockedProfit = "BlockedProfit"
        case marginInitial = "MarginInitial"
        case marginMaintenance = "MarginMaintenance"
    }
}

enum MixType: Codable {
    case double(Double)
    case string(String)
    case integer(Int)
    case boolean(Bool)
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(Bool.self) {
            self = .boolean(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(MixType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Datum"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        case .boolean(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}
