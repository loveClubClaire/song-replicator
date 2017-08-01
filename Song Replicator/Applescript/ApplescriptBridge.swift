//
//  ApplescriptBridgeNew.swift
//  Automated DJ
//
//  Created by Zachary Whitten on 8/1/16.
//  Copyright © 2016 16^2. All rights reserved.
//

import Foundation
import Cocoa

class ApplescriptBridge: NSObject {
    
    let instance: NSObject.Type
    
    override init() {
        let c: NSObject.Type = (NSClassFromString("MyApplescript") as? NSObject.Type)!
        instance = c
        super.init()
    }
    
    func getTrackInfo() -> [[Any]]{
        let name = "getTrackInfo"
        let selector = NSSelectorFromString(name)
        let returnObject = instance.perform(selector)
        let rawTrackInfo = returnObject?.takeUnretainedValue() as! NSArray
        return rawTrackInfo as! [[Any]]
    }
    
}
