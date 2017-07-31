//
//  MainWindow.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/31/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class MainWindow: NSObject {

        @IBAction func loadFinderSongs(_ sender: AnyObject) {
            let openPanel = NSOpenPanel()
            openPanel.allowedFileTypes = ["mp3","aiff","mpeg-4","m4a"]
            openPanel.allowsMultipleSelection = true
            openPanel.canChooseDirectories = false
            openPanel.canChooseFiles = true
            let result = openPanel.runModal()
            if result == NSApplication.ModalResponse.OK {
                print(openPanel.urls)
                //tableView.reloadData()
            }
    }
    
}
