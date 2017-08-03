//
//  MainTableViewControls.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 8/3/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class MainTableViewControls: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var finderTableView: NSTableView!
    @IBOutlet weak var iTunesTableView: NSTableView!
    
    var iTunesDataArray = [SongCellData]()
    var finderDataArray = [SongCellData]()
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == finderTableView {
            return finderDataArray.count
        }
        if tableView == iTunesTableView {
            return iTunesDataArray.count
        }
        else{
            //THIS SHOULD NEVER HAPPEN
            return 0
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //Get the column identifer and create an empty cellView variable
        let identifier = tableColumn?.identifier.rawValue
        var cellView: CustomTableCellView?
        if identifier == "finderSongs" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("finderSongCell"), owner: nil) as? CustomTableCellView)!
            cellView!.textField?.stringValue = finderDataArray[row].name
            cellView!.secondTextField?.stringValue = ""
        }
        
        if identifier == "iTunesSongs" {
            cellView = (tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("iTunesSongCell"), owner: nil) as? CustomTableCellView)!
            cellView!.textField?.stringValue = iTunesDataArray[row].name
            cellView!.secondTextField?.stringValue = iTunesDataArray[row].artist!
        }
        // return the populated NSTableCellView
        return cellView
    }
    
    //I THINK: Rows selected and currently being dragged
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        let registeredTypes = [NSPasteboard.PasteboardType.string]
        pboard.declareTypes(registeredTypes, owner: self)
        pboard.setData(data, forType: NSPasteboard.PasteboardType.string)
        return true
    }
    
    //I THINK: Determining where items currently being dragged can go
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation operation: NSTableView.DropOperation) -> NSDragOperation {
        if operation == .above {
            return .move
        }
        return []
    }
    
    //I THINK: Rearranging everything once user has dropped the items being dragged
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        //Get the indexes of items being moved
        let data:Data = info.draggingPasteboard().data(forType: NSPasteboard.PasteboardType.string)!
        let rowIndexes:IndexSet = NSKeyedUnarchiver.unarchiveObject(with: data) as! IndexSet
        //Create an array to store the items being moved
        var movingData:[SongCellData] = []
        //Itterate over the items being moved, add them to the movingData array and remove them from the dataArray
        for index in rowIndexes.enumerated().reversed(){
            let value:SongCellData = (tableView == finderTableView ? finderDataArray[index.element] : iTunesDataArray[index.element])
            movingData.append(value)
            _ = (tableView == finderTableView ? finderDataArray.remove(at: index.element) : iTunesDataArray.remove(at: index.element))
        }
        //Because we itterated over the items being removed backwards (to avoid indexs messing up and getting the wrong data) we reverse the movingData array to get in the correct order
        movingData.reverse()
        //Add the data to it's new location
        if (row > rowIndexes.first!){
            if (tableView == finderTableView) {finderDataArray.insert(contentsOf: movingData, at: row-movingData.count)}
            else {iTunesDataArray.insert(contentsOf: movingData, at: row-movingData.count)}
        }
        else {
            if (tableView == finderTableView) {finderDataArray.insert(contentsOf: movingData, at: row)}
            else {iTunesDataArray.insert(contentsOf: movingData, at: row)}
        }
        //Reload the table view
        tableView.reloadData()
        return true
    }
    
    func deleteShows() {
        var tableView:NSTableView
        var dataArray:[SongCellData]
        if isFinderViewSelected == true { tableView = finderTableView; dataArray = finderDataArray }
        else{ tableView = iTunesTableView; dataArray = iTunesDataArray }
        //get all selected elements in the tableview
        var selectedSongs = tableView.selectedRowIndexes
        //If the clicked show (if there is one) is not contained in the NSIndexSet, then add it. Because NSIndexSet is not mutable, we need to convert it into a NSMutableIndexSet, add the new value, and then set selectedShows to that new mutable index set.
        if(selectedSongs.contains(tableView.clickedRow) == false && tableView.clickedRow != -1){
            let selectedSongsMutable = NSMutableIndexSet.init(indexSet: selectedSongs)
            selectedSongsMutable.add(tableView.clickedRow)
            selectedSongs = selectedSongsMutable as IndexSet
        }
        //If the number of shows selected is greater than zero, alert the user about the deletion. If they agree to it, remove the items from the dataArray, save the new state of the dataArray, and refresh the tableView
        if selectedSongs.count > 0 {
            let myPopup: NSAlert = NSAlert()
            myPopup.messageText = "Are you sure you want to remove the selected songs?"
            myPopup.alertStyle = NSAlert.Style.warning
            myPopup.addButton(withTitle: "OK")
            myPopup.addButton(withTitle: "Cancel")
            let res = myPopup.runModal()
            if res == NSApplication.ModalResponse.alertFirstButtonReturn {
                let dataMutableArray = NSMutableArray(array: dataArray)
                dataMutableArray.removeObjects(at: selectedSongs)
                if isFinderViewSelected == true { finderDataArray = dataMutableArray as AnyObject as! [SongCellData] }
                else{ iTunesDataArray = dataMutableArray as AnyObject as! [SongCellData] }
                tableView.reloadData()
            }
        }
    }
    
    //Keep track of which TableView is currently selected by the user
    var isFinderViewSelected = false
    func tableViewSelectionDidChange(_ notification: Notification) {
        isFinderViewSelected = (notification.object as? NSTableView == finderTableView ? true : false)
    }
}
