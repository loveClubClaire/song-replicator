#  Song Replicator

Song Replicator is an application designed to take tracks in iTunes and changes the underlying audio file. It does this while preserving all of the tracks metadata. It also preserves the songs inclusion and location in all iTunes playlists. 

This application was designed so that a user could replace the underlying audio files of tracks in iTunes with higher bitrate files without the need to re-enter all of the tracks metadata or have the track removed from playlists. When a track is removed from iTunes, it is removed from all iTunes playlists. If a track with the same metadata is added to iTunes, that track is not added back to playlists. The result is the traditional way of replacing a tracks audio file with a higher quality audio file leads to the removal of said track from all playlists. With iTunes libraries containing dozens of playlists, the task of re-adding the new track to every playlist it was originally referenced in is extremely time consuming. With the Song Replicator, the audio files of tracks can be changed effortlessly. 

# Functionality 

The Song Replicator has two modes. The first mode replaces the underlying audio file of specific tracks with other audio files located on the hard disk. The second mode removes and re-adds selected tracks from iTunes. The second mode is used when tracks in iTunes become corrupted and will not display properly. Often the only recourse is removing the track from iTunes and re-adding it. With the Song Replicator, that process can be done effortlessly without the loss of metadata or playlist inclusion.

# Langauge

The Song Replicator is programmed in Swift 3 and AppleScript. It uses the AppleScript scripting bridge to natively execute the AppleScript code. AppleScript is used to interface with iTunes and Swift is used for everything else. Some of the functions written in AppleScript seem inefficient but because some of iTunes AppleScript functions are broken, they're the best they can be. 
