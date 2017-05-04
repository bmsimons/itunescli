//
//  main.swift
//  itunescli
//
//  Created by Bart Simons on 25/04/2017.
//  Copyright © 2017 Bart Simons. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

if (arguments.count == 1)
{
    printHelp()
}
else if (arguments.count >= 2)
{
    if (arguments[1] == "pause")
    {
        pauseSong()
    }
    
    if (arguments[1] == "play")
    {
        playSong()
    }
    
    if (arguments[1] == "playlists")
    {
        getPlaylists()
    }
    
    if (arguments[1] == "info")
    {
        print(currentSongInfo())
    }
    
    if (arguments[1] == "volume")
    {
        if (arguments.count == 3)
        {
            let volumeString: String = arguments[2]
            let volumeInteger = Int(volumeString)
            if (volumeInteger != nil)
            {
                setVolume(volume: volumeInteger!)
            }
        }
        else
        {
            print(getVolume())
        }
    }
    
    if (arguments[1] == "delplaylist")
    {
        delPlaylist(specifiedPlaylist: arguments[2])
    }
    
    if (arguments[1] == "playlisttracks")
    {
        getPlaylistTracks(specifiedPlaylist: arguments[2])
    }
}
