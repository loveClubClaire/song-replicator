script MyApplescript
    property parent : class "NSObject"
    
    on getTrackInfo()
        tell application "Music"
            set my_result to {}
            set my_playlist to get playlist "Music"
            try
                set end of my_result to name of tracks of my_playlist
                set end of my_result to time of tracks of my_playlist
                set end of my_result to artist of tracks of my_playlist
                set end of my_result to album artist of tracks of my_playlist
                set end of my_result to album of tracks of my_playlist
                set end of my_result to bit rate of tracks of my_playlist
                set end of my_result to media kind of tracks of my_playlist
                set end of my_result to compilation of tracks of my_playlist
                set end of my_result to persistent ID of tracks of my_playlist
            end try
            return my_result
        end tell
    end getTrackInfo
    
    on replaceTrack_aFilePath_(aUniqueID as string, aFilePath as string)
        tell application "Music"
            --new_track is the song being added, old_track is the song being removed
            set newPOSIXFile to aFilePath
            set newFile to (newPOSIXFile as POSIX file)
            set new_track to (add newFile to playlist "Music")
            
            set old_track to tracks of playlist "Music" where persistent ID is equal to aUniqueID
            set old_track to item 1 of old_track
            --Add the old tracks metadata to the new track
            --Some metadata is encapsulated with a try block because those pieces of metadata can be null.
            --Details
            --Using work
            set work of new_track to (work of old_track as string)
            set movement of new_track to (movement of old_track as string)
            set movement count of new_track to (movement count of old_track as integer)
            set movement number of new_track to (movement number of old_track as integer)
            --Using normal settings
            set name of new_track to (name of old_track as string)
            set artist of new_track to (artist of old_track as string)
            set album of new_track to (album of old_track as string)
            set album artist of new_track to (album artist of old_track as string)
            set composer of new_track to (composer of old_track as string)
            set grouping of new_track to (grouping of old_track as string)
            set genre of new_track to (genre of old_track as string)
            set year of new_track to (year of old_track as integer)
            set track count of new_track to (track count of old_track as integer)
            set track number of new_track to (track number of old_track as integer)
            set disc number of new_track to (disc number of old_track as integer)
            set disc count of new_track to (disc count of old_track as integer)
            set compilation of new_track to (compilation of old_track as boolean)
            set rating of new_track to (rating of old_track as integer)
            set loved of new_track to (loved of old_track as boolean)
            set bpm of new_track to (bpm of old_track as integer)
            set played count of new_track to (played count of old_track as integer)
            try
                set played date of new_track to (played date of old_track as date)
            end try
            set comment of new_track to (comment of old_track as string)
            --Lyrics
            next track
            set lyrics of new_track to (lyrics of old_track as string)
            --Options
            set shufflable of new_track to (shufflable of old_track as boolean)
            try
                set gapless of new_track to (gapless of old_track as boolean)
            end try
            set bookmarkable of new_track to (bookmarkable of old_track as boolean)
            --Sorting
            next track
            set sort album of new_track to (sort album of old_track as string)
            set sort artist of new_track to (sort artist of old_track as string)
            set sort album artist of new_track to (sort album artist of old_track as string)
            set sort name of new_track to (sort name of old_track as string)
            set sort composer of new_track to (sort composer of old_track as string)
    
            --Add the old tracks artwork to the new track
            set artCounter to 1
            
            repeat while artCounter is less than (count of artwork of old_track) + 1
                set myArt to data of artwork artCounter of old_track
                set data of artwork artCounter of new_track to myArt
                set artCounter to artCounter + 1
            end repeat
            
            --Replace the old track with the new track in every user made playlist
            set containing_playlists to user playlists of old_track
            repeat with aPlaylist in containing_playlists
                if smart of aPlaylist is false then
                    set aCounter to 1
                    repeat with aTrack in tracks in aPlaylist
                        if persistent ID of aTrack is equal to persistent ID of old_track then
                            delete track aCounter of aPlaylist
                            copy new_track to end of aPlaylist
                            my sortPlaylist(aPlaylist, aCounter)
                        end if
                        set aCounter to aCounter + 1
                    end repeat
                end if
            end repeat
            --remove old track
            delete old_track
            return persistent ID of new_track
        end tell
    end replaceTrack_aFilePath_
    
    on getTrackFilepath_(aUniqueID as string)
        tell application "Music"
            set old_track to tracks of playlist "Music" where persistent ID is equal to aUniqueID
            set old_track to item 1 of old_track
            set songLocation to get location of old_track
            return songLocation
        end tell
    end getTrackFilepath_
    
    --I do not believe that the scripting bridge can access this function because it's not declared correctly for that. None of the underscores in the name
    --Guess that's a clever way of making a function private?
    on sortPlaylist(aPlaylist, aPosition)
        tell application "Music"
            set playlistLength to count of tracks of aPlaylist
            set aCount to aPosition
            repeat while aCount is less than playlistLength
                move track aPosition of aPlaylist to end of aPlaylist
                set aCount to aCount + 1
            end repeat
        end tell
    end sortPlaylist
    
end script
