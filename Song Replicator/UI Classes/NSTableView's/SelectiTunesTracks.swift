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
    
    var artistDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    var albumDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    var trackDataSource:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == artistTableView {
            return artistDataSource.count
        }
        else if tableView == albumTableView {
            return albumDataSource.count
        }
        else if tableView == trackTableView {
            return trackDataSource.count
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
            cellView!.textField?.stringValue = trackDataSource[row]
        }
        if identifier == "time" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TimeCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = "0:00"
        }
        if identifier == "artist" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ArtistCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = "Artist"
        }
        if identifier == "album" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "AlbumCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = "Album"
        }
        if identifier == "bitrate" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BitrateCell"), owner: nil) as? NSTableCellView)!
            cellView!.textField?.stringValue = "320 kbps"
        }
    
        // return the populated NSTableCellView
        return cellView
    }
    
}
