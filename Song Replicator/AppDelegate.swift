//
//  AppDelegate.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/24/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var tableView: NSTableView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let registeredTypes = [NSPasteboard.PasteboardType.string]
        tableView.registerForDraggedTypes(registeredTypes)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

