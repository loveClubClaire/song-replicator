//
//  Song.swift
//  Song Replicator
//
//  Created by Zachary Whitten on 7/31/17.
//  Copyright © 2017 16^2. All rights reserved.
//

import Cocoa

class Song: NSObject {
    
    var name: String = ""
    var time: String = ""
    var artist: String = ""
    var albumArtist: String = ""
    var album: String = ""
    var bitRate: Int = 0
    
    static func getAlbumArtists(Songs: [Song]) -> [String]{
        var toReturn = [String]()
        for song in Songs{
                if toReturn.contains(song.albumArtist) == false {
                    toReturn.append(song.albumArtist)
                }
        }
        toReturn.sort() {
            item1, item2 in
            //Call custom function to remove the leading article (ya know, like grammer, 'a' 'an' & 'the') from the strings we're sorting
            let title1 = removeLeadingArticle(string: item1)
            let title2 = removeLeadingArticle(string: item2)
            //Get the result of a compare between the two strings. In this case we're using assending ordering
            var toReturn: Bool = title1.localizedCaseInsensitiveCompare(title2) == ComparisonResult.orderedAscending
            //Here we manually change the result of our compare if either string beings with a character which is not a letter. We do this so that they end up at the end of our list and not the start of it.
            //First we make sure neither of the strings are empty, as this crashes the program.
            if title1 != "" && title2 != "" {
                //If the first string starts with a non-letter than we change the result from false to true
                if CharacterSet.letters.contains((title1.characters.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title2.characters.first?.unicodeScalars.first)!) == true {
                    toReturn = false
                }
                //If the second string starts with a non-letter than we change the result from true to false
                if CharacterSet.letters.contains((title2.characters.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title1.characters.first?.unicodeScalars.first)!) == true {
                    toReturn = true
                }
                //If both strings begin with non-letter or letter characters, we don't change the compare result
            }
            //We return the comparison result
            return toReturn
        }
        toReturn[0] = "All (\(toReturn.count) Artists)"
        return toReturn
    }
    
    static func getAlbums(Songs: [Song]) -> [String]{
        var toReturn = [String]()
        for song in Songs{
            if toReturn.contains(song.album) == false {
                toReturn.append(song.album)
            }
        }
        //Here we implement a custom sort function. This function does the standard alpheptical sort, but it ignores leading articles. It also places strings begining with numbers at the bottom of the list rather than the top.
        toReturn.sort() {
            item1, item2 in
            //Call custom function to remove the leading article (ya know, like grammer, 'a' 'an' & 'the') from the strings we're sorting
            let title1 = removeLeadingArticle(string: item1)
            let title2 = removeLeadingArticle(string: item2)
            //Get the result of a compare between the two strings. In this case we're using assending ordering
            var toReturn: Bool = title1.localizedCaseInsensitiveCompare(title2) == ComparisonResult.orderedAscending
            //Here we manually change the result of our compare if either string beings with a character which is not a letter. We do this so that they end up at the end of our list and not the start of it.
            //First we make sure neither of the strings are empty, as this crashes the program.
            if title1 != "" && title2 != "" {
                //If the first string starts with a non-letter than we change the result from false to true
                if CharacterSet.letters.contains((title1.characters.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title2.characters.first?.unicodeScalars.first)!) == true {
                    toReturn = false
                }
                //If the second string starts with a non-letter than we change the result from true to false
                if CharacterSet.letters.contains((title2.characters.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title1.characters.first?.unicodeScalars.first)!) == true {
                    toReturn = true
                }
                //If both strings begin with non-letter or letter characters, we don't change the compare result
            }
            //We return the comparison result
            return toReturn
        }
        toReturn[0] = "All (\(toReturn.count) Albums)"
        return toReturn
    }
    
    
    private static func removeLeadingArticle(string: String) -> String {
        let theArticle = "the "
        let aArtical = "a "
        let anArtical = "an "
        if string.characters.count > theArticle.characters.count && string.lowercased().hasPrefix(theArticle) {
            return string.substring(from: string.index(string.startIndex, offsetBy: theArticle.characters.count))
        }
        if string.characters.count > aArtical.characters.count && string.lowercased().hasPrefix(aArtical) {
            return string.substring(from: string.index(string.startIndex, offsetBy: aArtical.characters.count))
        }
        if string.characters.count > anArtical.characters.count && string.lowercased().hasPrefix(anArtical) {
            return string.substring(from: string.index(string.startIndex, offsetBy: anArtical.characters.count))
        }
        else {
            return string
        }
    }
    
}
