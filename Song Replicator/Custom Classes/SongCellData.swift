//
//  SongCellData.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 8/3/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class SongCellData: NSObject {

    var name: String
    var artist: String?
    var URL: URL?
    var uniqueID: String?
    
    init(aName: String){
        name = aName
    }
    
    
}
