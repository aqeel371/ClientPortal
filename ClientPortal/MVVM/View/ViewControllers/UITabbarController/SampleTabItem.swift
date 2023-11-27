//
//  SampleTabItem.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
import UIKit
import CBTabBarController

extension String: CBTabMenuItem {
    public var title: String? { return self }
    public var attributedTitle: NSAttributedString? { return nil }
}

class SampleTabItem: UITabBarItem, CBExtendedTabItem {

    public var attributedTitle: NSAttributedString? {
        guard let title = title else { return nil }
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
    }
}
