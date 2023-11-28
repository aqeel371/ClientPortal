//
//  Enum.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 28/11/2023.
//

import Foundation
import UIKit

enum Storybords:String {
    case Main = "Main"
}

enum ViewControllers:String{
    
    case SigninVC = "SigninVC"
    case MainVC = "MainVC"
    case AccountsVC = "AccountsVC"
    case ChangePasswordVC = "ChangePasswordVC"
    case InternalTabsVC = "InternalTabsVC"
    
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
        }
        
        
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: self.rawValue)
        return initialViewController as! T
    }
}


enum TabType{
    case deposit
    case withdraw
    case transfer
}
