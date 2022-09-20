//
//  PlayerViewModel.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import Foundation

enum PlayerState: Comparable {
    case unknown
    case buffering
    case playing
    case paused
    case stopped
    case failed
    case ended

    var controlActionTitle: String {
        switch self {
        case .unknown, .paused, .stopped, .failed, .ended:
            return "Play"
        case .buffering:
            return "Loading..."
        case .playing:
            return "Pause"
        }
    }
}

struct Track {
    let filePath: URL
}

class PlayerViewModel: ObservableObject {
    @Published var playerState: PlayerState {
        didSet {
            controlButtonTitle = playerState.controlActionTitle
        }
    }
    private(set) var controlButtonTitle: String
    var controlIconName: String {
        isPlaying ? "pause" : "play"
    }

    let track: Track

    // MARK: - Initializer

    init(track: Track) {
        let initialPlayerState = PlayerState.unknown
        self.controlButtonTitle = initialPlayerState.controlActionTitle
        self.playerState = initialPlayerState
        self.track = track
    }

    // MARK: - Controls

    func togglePlayerState() {
        if playerState == .playing {
            playerState = .paused
        } else {
            playerState = .playing
        }
    }

    // MARK: - Load Track

    func loadTrack(_ track: Track) {
        // todo: to be implemented ...
    }

    // MARK: - Helpers

    var durationString: String {
        return "11:46"
    }

    var isPlaying: Bool {
        return playerState == .playing
    }
}
