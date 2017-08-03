//
//  SelectiTunesTracks.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/31/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class SelectiTunesTracks: NSObject, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var artistTableView: NSTableView!
    @IBOutlet weak var albumTableView: NSTableView!
    @IBOutlet weak var trackTableView: NSTableView!
    @IBOutlet weak var selectiTunesTracksWindow: NSWindow!
    
    var artistDataSource = [String]()
    var albumDataSource = [String]()
    var tracks = [Song]()
    
    var masterTracks = [Song]()
    var allAlbums = [String]()
    
    func spawnSelectiTunesTracksWindow(){
        masterTracks.append(contentsOf: tracks)
        artistDataSource = Song.getAlbumArtists(Songs: tracks)
        artistTableView.reloadData()
        artistTableView.selectRowIndexes(NSIndexSet(index: 0) as IndexSet, byExtendingSelection: false)
        trackTableView.reloadData()
        selectiTunesTracksWindow.center()
        selectiTunesTracksWindow.makeKeyAndOrderFront(self)
    }
    
    //Button Functions
    @IBAction func cancelButton(_ sender: AnyObject) {
        selectiTunesTracksWindow.orderOut(self)
    }
    
    @IBAction func okButton(_ sender: AnyObject) {
        var cellData = [SongCellData]()
        for index in trackTableView.selectedRowIndexes{
            let newCell = SongCellData.init(aName: tracks[index].name)
            newCell.artist = tracks[index].artist
            newCell.uniqueID = tracks[index].uniqueID
            cellData.append(newCell)
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == artistTableView {
            return artistDataSource.count
        }
        else if tableView == albumTableView {
            return albumDataSource.count
        }
        else if tableView == trackTableView {
            return tracks.count
        }
        else{
            //THIS SHOULD NEVER HAPPEN
            return 0
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //Get the column identifer and create an empty cellView variable
        let identifier = tableColumn?.identifier.rawValue
        
        var cellView: NSTableCellView?
        
        if identifier == "artists" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ArtistsCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = artistDataSource[row]
        }
        if identifier == "albums" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AlbumsCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = albumDataSource[row]
        }
        if identifier == "name" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NameCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = tracks[row].name
        }
        if identifier == "time" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TimeCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = tracks[row].time
        }
        if identifier == "artist" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ArtistCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = tracks[row].artist
        }
        if identifier == "album" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AlbumCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = tracks[row].album
        }
        if identifier == "bitrate" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BitrateCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = String(tracks[row].bitRate) + " kbps"
        }
    
        // return the populated NSTableCellView
        return cellView
    }
    
    func tableViewSelectionDidChange(_ notification: Notification){
        print(artistTableView.selectedRow); print(albumTableView.selectedRow)
        let selectedArtist = artistDataSource[artistTableView.selectedRow]
        let selectedAlbum:String; if albumDataSource.count > 0{selectedAlbum = albumDataSource[albumTableView.selectedRow] } else {selectedAlbum = ""}
        if notification.object as? NSTableView == artistTableView {
            if selectedArtist.starts(with: "All ("){
                if allAlbums.count == 0{
                    allAlbums = Song.getAlbums(Songs: tracks)
                }
                albumDataSource = allAlbums
            }
            else{
                albumDataSource = Song.getAlbumsBy(artist: selectedArtist, songs: masterTracks)
            }
            albumTableView.reloadData()
            albumTableView.selectRowIndexes(NSIndexSet(index: 0) as IndexSet, byExtendingSelection: false)
        }
        else if notification.object as? NSTableView == albumTableView {
            print("Album")
            if selectedAlbum.starts(with: "All ("){
                if selectedArtist.starts(with: "All ("){
                    //Get all tracks
                    tracks = masterTracks
                }
                else{
                    //Get all tracks assoicated with artist
                    tracks = Song.getTracksBy(artist: selectedArtist, offAlbum: nil, with: masterTracks)
                }
            }
            else{
                if selectedArtist.starts(with: "All ("){
                   //Get all tracks assoicated with album
                    tracks = Song.getTracksBy(artist: nil, offAlbum: selectedAlbum, with: masterTracks)
                }
                else{
                    //Get all tracks assoicated with artist and album
                    tracks = Song.getTracksBy(artist: selectedArtist, offAlbum: selectedAlbum, with: masterTracks)
                }
            }
            trackTableView.reloadData()
        }
        else if notification.object as? NSTableView == trackTableView {
            print("Track")
        }
    }
}
