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
        return toReturn
    }
    
    static func getAlbums(Songs: [Song]) -> [String]{
        var toReturn = [String]()
        for song in Songs{
            if toReturn.contains(song.album) == false {
                toReturn.append(song.album)
            }
        }

        toReturn.sort()
        return toReturn
    }
    
}
