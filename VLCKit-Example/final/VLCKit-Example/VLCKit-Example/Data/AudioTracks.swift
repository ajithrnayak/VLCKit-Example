//
//  AudioTracks.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import Foundation

enum AudioTracks {

    static var sampleFilePath1: URL {
        return Bundle.main.url(forResource: "audio_sample", withExtension: ".ogg")!
    }

    static var sampleFilePath2: URL {
        return Bundle.main.url(forResource: "sample_ogg_file", withExtension: ".ogg")!
    }

    static var remoteSampleFileURL: URL {
        return URL(string: "https://upload.wikimedia.org/wikipedia/commons/c/c8/Example.ogg")!
    }
}

