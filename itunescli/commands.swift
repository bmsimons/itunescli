//
//  commands.swift
//  itunescli
//
//  Created by Bart Simons on 25/04/2017.
//  Copyright © 2017 Bart Simons. All rights reserved.
//

import ScriptingBridge

let app: iTunesApplication = SBApplication(bundleIdentifier: "com.apple.iTunes")!

func pingCommand() -> String
{
    return "Pong!"
}

func getState() -> Int
{
    switch app.playerState!
    {
        case iTunesEPlS.stopped:
            return 1
        
        case iTunesEPlS.playing:
            return 2
        
        case iTunesEPlS.paused:
            return 3
        
        case iTunesEPlS.fastForwarding:
            return 4
        
        case iTunesEPlS.rewinding:
            return 5
    }
}

func printHelp()
{
    print("itunescli - Bart Simons, 2017")
    print("")
    print("Usage: ")
    print("")
    print("itunescli pause           (pause current playing song)")
    print("itunescli play            (resume current playing song)")
    print("itunescli volume {0-100}  (set or get volume)")
    print("itunescli info            (fetch current track info)")
    print("itunescli playlists       (gets a list of playlists)")
    print("itunescli delplaylist     (deletes a specified playlist)")
    print("itunescli playlisttracks  (lists the tracks of a playlist)")
}

func getPlaylistTracks(specifiedPlaylist: String)
{
    let playlists: SBElementArray? = app.playlists!()
    for playlist in playlists!
    {
        let playlist = (playlist as! iTunesPlaylist)
        if (playlist.name! == specifiedPlaylist)
        {
            let tracks: SBElementArray? = playlist.tracks!()
            for track in tracks!
            {
                let track = (track as! iTunesTrack)
                print(track.name! + " - " + track.artist!)
            }
        }
    }
}

func delPlaylist(specifiedPlaylist: String)
{
    let playlists: SBElementArray? = app.playlists!()
    for playlist in playlists!
    {
        let playlist = (playlist as! iTunesPlaylist)
        if (playlist.name! == specifiedPlaylist)
        {
            playlist.delete!()
        }
    }
}

func getPlaylists()
{
    let playlists: SBElementArray? = app.playlists!()
    for playlist in playlists!
    {
        let playlist = (playlist as! iTunesPlaylist)
        print(playlist.name!)
    }
}

func currentSongInfo() -> String
{
    let currentTrack: iTunesTrack? = app.currentTrack!
    let trackName: String? = currentTrack?.name!
    let trackArtist: String? = currentTrack?.artist!
    return trackName! + " - " + trackArtist!
}

func pauseSong()
{
    let playerState = getState()
    if (playerState == 2)
    {
        app.pause!()
    }
}

func playSong()
{
    let playerState = getState()
    if (playerState == 1 || playerState == 3)
    {
        app.playpause!()
    }
}

func getVolume() -> String
{
    return String(app.soundVolume!)
}

func setVolume(volume: Int)
{
    app.setSoundVolume!(volume)
}
