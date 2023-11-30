//
//  Enum.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import Foundation
import UIKit

// MARK: - Navigation
enum Storybords:String {
    case Main = "Main"
    case Deposit = "Deposit"
    case Menu = "Menu"
}

enum ViewControllers:String{
    
    case SigninVC = "SigninVC"
    case MainVC = "MainVC"
    case AccountsVC = "AccountsVC"
    case ChangePasswordVC = "ChangePasswordVC"
    case InternalTabsVC = "InternalTabsVC"
    case ProfileVC = "ProfileVC"
    case ForgetPassVC = "ForgetPassVC"
    case DepositVC = "DepositVC"
    case CryptoWireVC = "CryptoWireVC"
    case CryptoDetailsVC = "CryptoDetailsVC"
    case WireTransferDetailsVC = "WireTransferDetailsVC"
    case InstantTransferVC = "InstantTransferVC"
    case PerfectMoneyVC = "PerfectMoneyVC"
    case StickSkrillVC = "StickSkrillVC"
    case MenuAccountsVC = "MenuAccountsVC"
    case MenuTransactionVC = "MenuTransactionVC"
    case MenuTrainingVC = "MenuTrainingVC"
    case MenuProfileVC = "MenuProfileVC"
    case MenuTardesVC = "MenuTardesVC"
    case TradeDetailsVC = "TradeDetailsVC"
    case MenuPlateformVC = "MenuPlateformVC"
    case BankAccountsVC = "BankAccountsVC"
    case WalletsVC = "WalletsVC"
    case ReportsVC = "ReportsVC"
    
    
    public func getViewController<T:UIViewController>() -> T {
        var storyBoard: Storybords = .Main
        switch self {
        case .SigninVC:
            storyBoard = .Main
        case .MainVC:
            storyBoard = .Main
        case .AccountsVC:
            storyBoard = .Main
        case .ChangePasswordVC:
            storyBoard = .Main
        case .InternalTabsVC:
            storyBoard = .Main
        case .ProfileVC:
            storyBoard = .Main
        case .ForgetPassVC:
            storyBoard = .Main
        case .DepositVC:
            storyBoard = .Deposit
        case .CryptoWireVC:
            storyBoard = .Deposit
        case .CryptoDetailsVC:
            storyBoard = .Deposit
        case .WireTransferDetailsVC:
            storyBoard = .Deposit
        case .InstantTransferVC:
            storyBoard = .Deposit
        case .PerfectMoneyVC:
            storyBoard = .Deposit
        case .StickSkrillVC:
            storyBoard = .Deposit
        case .MenuAccountsVC:
            storyBoard = .Menu
        case .MenuTrainingVC:
            storyBoard = .Menu
        case .MenuTransactionVC:
            storyBoard = .Menu
        case .MenuProfileVC:
            storyBoard = .Menu
        case .MenuTardesVC:
            storyBoard = .Menu
        case .TradeDetailsVC:
            storyBoard = .Menu
        case .MenuPlateformVC:
            storyBoard = .Menu
        case .BankAccountsVC:
            storyBoard = .Menu
        case .WalletsVC:
            storyBoard = .Menu
        case .ReportsVC:
            storyBoard = .Menu
        }
        
        
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: self.rawValue)
        return initialViewController as! T
    }
}

// MARK: - Other
enum TabType{
    case deposit
    case withdraw
    case transfer
}

enum TransferType{
    case Instant
    case Wire
    case Crypto
    case PerfectMoney
    case Stick
    case Skrill
}
