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

    func replaceTrack(aUniqueID: String, aFilepath: String) -> String{
        let name = "replaceTrack:aFilePath:"
        let selector = NSSelectorFromString(name)
        var result: Unmanaged<AnyObject>? = nil
        while  result == nil {
            result = instance.perform(selector, with: aUniqueID, with: aFilepath)
        }
        return result?.takeUnretainedValue() as! String
    }
    
    func getTrackFilepath(aUniqueID: String) -> NSURL{
        let name = "getTrackFilepath:"
        let selector = NSSelectorFromString(name)
        let result = instance.perform(selector, with: aUniqueID)
        return result?.takeUnretainedValue() as! NSURL
    }
}
