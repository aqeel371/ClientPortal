//
//  Global.swift
//  ClientPortal
//
//  Created by Muhammad  Aqeel on 27/11/2023.
//

import Foundation
class Global{
    class var shared : Global {
        struct Static{
            static let instance : Global = Global()
        }
        return Static.instance
    }
    var tokken:String?
}
