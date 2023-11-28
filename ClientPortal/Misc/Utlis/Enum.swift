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
    
    public func getViewController<T:UIViewController>() -> T {
        var storyBoard: Storybords = .Main
        switch self {
        case .SigninVC:
            storyBoard = .Main
        case .MainVC:
            storyBoard = .Main
        case .AccountsVC:
            storyBoard = .Main
        }
        
        
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: self.rawValue)
        return initialViewController as! T
    }
}
