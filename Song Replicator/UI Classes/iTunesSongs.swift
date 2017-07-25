//
//  iTunesSongs.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/24/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class iTunesSongs: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    
    var dataArray:[String] = ["Debasis Das","John Doe","Jane Doe","Mary Jane"]
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //Get the column identifer and create an empty cellView variable
        let identifier = tableColumn?.identifier.rawValue
        
        var cellView: CustomTableCellView?
        
        if identifier == "iTunesSongs" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("iTunesSongCell"), owner: nil) as? CustomTableCellView)!
            
            
            
            cellView!.textField?.stringValue = dataArray[row]
            cellView!.secondTextField?.stringValue = "Blink 182"
        }
        
        // return the populated NSTableCellView
        return cellView
    }
   
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        let registeredTypes = [NSPasteboard.PasteboardType.string]
        pboard.declareTypes(registeredTypes, owner: self)
        pboard.setData(data, forType: NSPasteboard.PasteboardType.string)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation operation: NSTableView.DropOperation) -> NSDragOperation {
        if operation == .above {
            return .move
        }
        return .every
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        let data:Data = info.draggingPasteboard().data(forType: NSPasteboard.PasteboardType.string)!
        let rowIndexes:IndexSet = NSKeyedUnarchiver.unarchiveObject(with: data) as! IndexSet
        let value:String = dataArray[rowIndexes.first!]
        dataArray.remove(at: rowIndexes.first!)
        
        if (row > dataArray.count) {
            dataArray.insert(value, at: row-1)
        }
        else {
            dataArray.insert(value, at: row)
        }
        
        tableView.reloadData()
        return true
    }
  }
