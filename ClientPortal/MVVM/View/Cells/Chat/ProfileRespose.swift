//
//  ProfileRespose.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 05/12/2023.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    var status: Bool?
    var message: String?
    var result: ProfileResult?
    var isSuccess: Bool?
}

/// MARK: - Result
struct ProfileResult: Codable {
    var id: Int?
    var title, firstName, lastName, email: String?
    var city, state, country, nationality: String?
    var phone, mobile, dob, gender: String?
    var address, address2, zipCode, referral: String?
    var language: String?
    var fatca, politicallyExposed, workedInCrypto: Bool?
    var taxIdentificationNumber, source, docType, documentNo: String?
    var dateOfIssue, dateOfExpiry, countryOfIssue, employmentStatus: String?
    var profession, jobTitle, employer, annualIncome: String?
    var sourceOfFunds, workedInFinancial, kycStatus: String?
    var isFunded, emailVerified, phoneVerified, startTrading: Bool?
    var submitClientProfile, submitIbProfile, submitIbQuestionaire, isLead: Bool?
    var isIb, isClient, isCorporate, isBlocked: Bool?
    var isActive, isDeleted: Bool?
    var supplier, pageURL, entity: String?
    var retention: Int?
    var accountStatus, clientType, accountStage, ip: String?
    var lastLogin, countryOfBirth, educationLevel, ownCompany: String?
    var taxResidency, cfdFrequency, forexFrequency, otherDerivativesFrequency: String?
    var sharesFrequency, netWorth, investmentPurpose, riskLevel: String?
    var affiliateID, utmCampaign, utmSource, utmMedium: String?
    var utmTerm, utmContent, utmCategory, website: String?
    var newsLetters, tradeDisabled, complianceCompleted, emailOptOut: Bool?
    var leadConverted, acceptedTerms, acceptedMandatoryInfo, acceptedExecutionPolicy: Bool?
    var acceptedSourceIncome, acceptedWarning, acceptedCliebntAgrement, acceptedPrivacy: Bool?
    var acceptedConflicts, acceptedRisk, acceptedCategoriztionPolicy, acceptedStatenebt: Bool?
    var acceptedCookies: Bool?
    var ibid: Int?
    var createdAt, updatedAt: String?
    var agentID, createdBy, updatedBy: Int?
    var user: ProfileUser?

    enum CodingKeys: String, CodingKey {
        case id, title, firstName, lastName, email, city, state, country, nationality, phone, mobile, dob, gender, address, address2, zipCode, referral, language, fatca, politicallyExposed, workedInCrypto, taxIdentificationNumber, source, docType, documentNo, dateOfIssue, dateOfExpiry, countryOfIssue, employmentStatus, profession, jobTitle, employer, annualIncome, sourceOfFunds, workedInFinancial, kycStatus, isFunded, emailVerified, phoneVerified, startTrading, submitClientProfile, submitIbProfile, submitIbQuestionaire, isLead, isIb, isClient, isCorporate, isBlocked, isActive, isDeleted, supplier
        case pageURL = "pageUrl"
        case entity, retention, accountStatus, clientType, accountStage, ip, lastLogin, countryOfBirth, educationLevel, ownCompany, taxResidency, cfdFrequency, forexFrequency, otherDerivativesFrequency, sharesFrequency, netWorth, investmentPurpose, riskLevel
        case affiliateID = "affiliateId"
        case utmCampaign, utmSource, utmMedium, utmTerm, utmContent, utmCategory, website, newsLetters, tradeDisabled, complianceCompleted, emailOptOut, leadConverted, acceptedTerms, acceptedMandatoryInfo, acceptedExecutionPolicy, acceptedSourceIncome, acceptedWarning, acceptedCliebntAgrement, acceptedPrivacy, acceptedConflicts, acceptedRisk, acceptedCategoriztionPolicy, acceptedStatenebt, acceptedCookies, ibid, createdAt, updatedAt
        case agentID = "agentId"
        case createdBy, updatedBy
        case user = "User"
    }
}

// MARK: - User
struct ProfileUser: Codable {
    var firstName, lastName, phone, email: String?
}
