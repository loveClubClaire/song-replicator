//
//  MainWindow.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/31/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class MainWindow: NSObject {

    @IBOutlet weak var selectiTunesTracks: SelectiTunesTracks!
    
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

    @IBAction func loadiTunesSongs(_ sender: AnyObject) {
        let applescriptBridge = ApplescriptBridge()
        let result = applescriptBridge.getTrackInfo()
        
        var index = 0
        var allSongs = [Song]()
        while index < result[0].count {
            if (result[6][index] as! NSAppleEventDescriptor).stringValue == "kMdS" && result[1][index] as? String != nil {
                let newSong = Song()
                newSong.name = result[0][index] as! String
                newSong.time = result[1][index] as! String
                newSong.artist = result[2][index] as! String
                newSong.albumArtist = result[3][index] as! String
                newSong.album = result[4][index] as! String
                newSong.bitRate = result[5][index] as! Int
                allSongs.append(newSong)
            }
            index = index + 1
        }
        
        //Get data for selecting songs in iTunes and add it to the selectiTunesTracks class
        selectiTunesTracks.tracks = allSongs
        //Show window
        selectiTunesTracks.spawnSelectiTunesTracksWindow()
        
    }
    
}
