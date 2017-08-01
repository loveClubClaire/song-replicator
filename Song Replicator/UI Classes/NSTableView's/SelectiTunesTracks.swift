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
    
    var artistDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    var albumDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    var trackDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    
    var tracks = [Song]()
    
    func spawnSelectiTunesTracksWindow(){
        artistDataSource = Song.getAlbumArtists(Songs: tracks)
        albumDataSource = Song.getAlbums(Songs: tracks)
        artistTableView.reloadData()
        albumTableView.reloadData()
        trackTableView.reloadData()
        selectiTunesTracksWindow.center()
        selectiTunesTracksWindow.makeKeyAndOrderFront(self)
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
    
}
