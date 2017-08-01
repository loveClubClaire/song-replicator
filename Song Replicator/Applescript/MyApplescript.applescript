script MyApplescript
    property parent : class "NSObject"
    
    on getTrackInfo()
        tell application "iTunes"
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
            end try
            return my_result
        end tell
    end getTrackInfo
    
end script
