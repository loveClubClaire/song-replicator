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
    var compilation: Bool = false
    var uniqueID: String = ""
    
    //Returns a string array of all albums by a given artist. We can ignore all albums that are in a compilation because the respect artists don't show in the artists table view, so they wont be passed to this funciton. If the track has an album artist we use that to look for corresponding albums (i.e. look for albums by Jay-Z not Jay-Z feat. Frank Ocean). We also do a case insensitive compare so that Albums by blink-182 and Blink-182 show up under the same artist.
    static func getAlbumsBy(artist: String, songs: [Song]) -> [String]{
        var matchingSongs = [Song]()
        for song in songs {
            if song.compilation == false{
                if song.albumArtist == ""{
                    if song.artist.caseInsensitiveCompare(artist) == .orderedSame{
                        matchingSongs.append(song)
                    }
                }
                else{
                    if song.albumArtist.caseInsensitiveCompare(artist) == .orderedSame{
                        matchingSongs.append(song)
                    }
                }
            }
        }
        return Song.getAlbums(Songs: matchingSongs)
    }
    
    static func getTracksBy(artist: String?, offAlbum album: String?, with songs:[Song]) -> [Song]{
        var matchingSongs = [Song]()
        for song in songs {
            //If only given an artist, get all tracks which match the artist
            //See getAlbumsBy for detailed understanding of how this if statement logic works
            if artist != nil && album == nil {
                if song.albumArtist == ""{
                    if song.artist.caseInsensitiveCompare(artist!) == .orderedSame{
                        matchingSongs.append(song)
                    }
                }
                else{
                    if song.albumArtist.caseInsensitiveCompare(artist!) == .orderedSame{
                        matchingSongs.append(song)
                    }
                }
            }
            //If only given an album, get all tracks which match the album
            if artist == nil && album != nil {
                if song.album.caseInsensitiveCompare(album!) == .orderedSame{
                    matchingSongs.append(song)
                }
            }
            //If we're given both an artist and an album, get all tracks which match both the artist and the album given
            if artist != nil && album != nil {
                if song.albumArtist == ""{
                    if song.artist.caseInsensitiveCompare(artist!) == .orderedSame{
                        if song.album.caseInsensitiveCompare(album!) == .orderedSame{
                            matchingSongs.append(song)
                        }
                    }
                }
                else{
                    if song.albumArtist.caseInsensitiveCompare(artist!) == .orderedSame{
                        if song.album.caseInsensitiveCompare(album!) == .orderedSame{
                            matchingSongs.append(song)
                        }
                    }
                }
            }
        }
        return Song.getTracks(Songs: matchingSongs)
    }
    
    
    static func getAlbumArtists(Songs: [Song]) -> [String]{
        var toReturn = [String]()
        for song in Songs{
            if song.compilation == false {
                if song.albumArtist == ""{
                    if toReturn.contains(where: {$0.caseInsensitiveCompare(song.artist) == .orderedSame}) == false {
                        toReturn.append(song.artist)
                    }
                }
                else{
                    if toReturn.contains(where: {$0.caseInsensitiveCompare(song.albumArtist) == .orderedSame}) == false {
                        toReturn.append(song.albumArtist)
                    }
                }
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
                if CharacterSet.letters.contains((title1.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title2.first?.unicodeScalars.first)!) == true {
                    toReturn = false
                }
                //If the second string starts with a non-letter than we change the result from true to false
                if CharacterSet.letters.contains((title2.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title1.first?.unicodeScalars.first)!) == true {
                    toReturn = true
                }
                //If both strings begin with non-letter or letter characters, we don't change the compare result
            }
            //We return the comparison result
            return toReturn
        }
        while toReturn.first == "" { toReturn.removeFirst() }
        toReturn.insert("All (\(toReturn.count) Artists)", at: 0)
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
                if CharacterSet.letters.contains((title1.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title2.first?.unicodeScalars.first)!) == true {
                    toReturn = false
                }
                //If the second string starts with a non-letter than we change the result from true to false
                if CharacterSet.letters.contains((title2.first?.unicodeScalars.first)!) == false && CharacterSet.letters.contains((title1.first?.unicodeScalars.first)!) == true {
                    toReturn = true
                }
                //If both strings begin with non-letter or letter characters, we don't change the compare result
            }
            //We return the comparison result
            return toReturn
        }
        while toReturn.first == "" { toReturn.removeFirst() }
        toReturn.insert("All (\(toReturn.count) Albums)", at: 0); if (toReturn.count == 2){toReturn[0] = "All (\(toReturn.count - 1) Album)"};
        return toReturn
    }
    
    static func getTracks(Songs: [Song]) -> [Song]{
        var toReturn = [Song]()
        for song in Songs{
            if toReturn.contains(song) == false {
                toReturn.append(song)
            }
        }
        return toReturn
    }
    
    private static func removeLeadingArticle(string: String) -> String {
        let theArticle = "the "
        let aArtical = "a "
        let anArtical = "an "
        if string.count > theArticle.count && string.lowercased().hasPrefix(theArticle) {
            return String(string[(string.index(string.startIndex, offsetBy: theArticle.count))...])
        }
        if string.count > aArtical.count && string.lowercased().hasPrefix(aArtical) {
            return String(string[(string.index(string.startIndex, offsetBy: aArtical.count))...])
        }
        if string.count > anArtical.count && string.lowercased().hasPrefix(anArtical) {
            return String(string[(string.index(string.startIndex, offsetBy: anArtical.count))...])
        }
        else {
            return string
        }
    }
    
}
