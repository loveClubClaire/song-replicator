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
    @IBOutlet weak var mainTableViewControls: MainTableViewControls!
    @IBOutlet weak var readdSongs: NSButton!
    @IBOutlet weak var loadFilesButton: NSButton!
    
    @IBAction func loadFinderSongs(_ sender: AnyObject) {
            let openPanel = NSOpenPanel()
            openPanel.allowedFileTypes = ["mp3","aiff","mpeg-4","m4a"]
            openPanel.allowsMultipleSelection = true
            openPanel.canChooseDirectories = false
            openPanel.canChooseFiles = true
            let result = openPanel.runModal()
            if result == NSApplication.ModalResponse.OK {
                var cellData = [SongCellData]()
                for url in openPanel.urls {
                    let newCell = SongCellData.init(aName: url.lastPathComponent)
                    newCell.URL = url
  
                    cellData.append(newCell)
                }
                mainTableViewControls.finderDataArray = cellData
                mainTableViewControls.finderTableView.reloadData()
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
                newSong.compilation = result[7][index] as! Bool
                newSong.uniqueID = result[8][index] as! String
                allSongs.append(newSong)
            }
            index = index + 1
        }
        //Get data for selecting songs in iTunes and add it to the selectiTunesTracks class
        selectiTunesTracks.tracks = allSongs
        //Show window
        selectiTunesTracks.spawnSelectiTunesTracksWindow()
    }
    

    
    @IBAction func switchButtonPressed(_ sender: AnyObject) {
        let applescriptBridge = ApplescriptBridge()
        for (index, song) in mainTableViewControls.iTunesDataArray.enumerated() {
            var filepath: URL
            if readdSongs.state == .off {filepath = mainTableViewControls.finderDataArray[index].URL!}
            else {
                filepath = applescriptBridge.getTrackFilepath(aUniqueID: mainTableViewControls.iTunesDataArray[index].uniqueID!) as URL
                let fileManager = FileManager.default
                do {
                    let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString).appendingPathExtension(filepath.pathExtension)
                    try fileManager.moveItem(at: filepath, to: url)
                    filepath = url
                }
                catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
                song.uniqueID = applescriptBridge.replaceTrack(aUniqueID: song.uniqueID!, aFilepath: (Bundle.main.path(forResource: "SUCCESS", ofType: ".mp3"))!)
            }
            _ = applescriptBridge.replaceTrack(aUniqueID: song.uniqueID!, aFilepath: filepath.absoluteString.removingPercentEncoding!)
        }
        mainTableViewControls.finderDataArray.removeAll()
        mainTableViewControls.iTunesDataArray.removeAll()
        mainTableViewControls.finderTableView.reloadData()
        mainTableViewControls.iTunesTableView.reloadData()
    }
    
    @IBAction func readdSongsButtonPressed(_ sender: AnyObject){
        if readdSongs.state == .off{
            loadFilesButton.isEnabled = true
            mainTableViewControls.finderTableView.isEnabled = true
        }
        else{
            loadFilesButton.isEnabled = false
            mainTableViewControls.finderTableView.isEnabled = false
        }
    }
    
}
