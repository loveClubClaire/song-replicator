//
//  AppDelegate.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/24/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa
import AppleScriptObjC

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var iTunesSongsTableView: NSTableView!
    @IBOutlet weak var finderSongsTableView: NSTableView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //Required for the scripting bridge to function
        Bundle.main.loadAppleScriptObjectiveCScripts()
        //Allow for Table Views to have items dragged
        let registeredTypes = [NSPasteboard.PasteboardType.string]
        iTunesSongsTableView.registerForDraggedTypes(registeredTypes)
        finderSongsTableView.registerForDraggedTypes(registeredTypes)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

