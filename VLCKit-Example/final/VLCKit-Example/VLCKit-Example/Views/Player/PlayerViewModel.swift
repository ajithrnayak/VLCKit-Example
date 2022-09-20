//
//  PlayerViewModel.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import Foundation
import MobileVLCKit
import Combine

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
    @Published var durationString: String = ""
    private(set) var controlButtonTitle: String
    var controlIconName: String {
        isPlaying ? "pause" : "play"
    }

    let track: Track
    lazy var mediaPlayer = VLCMediaPlayer()
    var cancellable = Set<AnyCancellable>()

    // MARK: - Initializer

    init(track: Track) {
        let initialPlayerState = PlayerState.unknown
        self.controlButtonTitle = initialPlayerState.controlActionTitle
        self.playerState = initialPlayerState

        self.track = track
        loadTrack(track)

        setTrackDuration()
        setupObservers()
    }

    deinit {
        cancelObservers()
    }

    // MARK: - Controls

    func togglePlayerState() {
        if playerState == .playing {
            playerState = .paused
            pause()
        } else {
            playerState = .playing
            play()
        }
    }

    func play() {
        self.mediaPlayer.play()
    }

    func stop() {
        self.mediaPlayer.stop()
    }

    func pause() {
        self.mediaPlayer.pause()
    }

    func setPosition(_ position: Double) {
        self.mediaPlayer.position = Float(position)
    }

    // MARK: - Load Track

    func loadTrack(_ track: Track) {
        let media = VLCMedia(url: track.filePath)
        mediaPlayer.media = media
    }

    // MARK: - Observers

    func setupObservers() {
        observeRemainingTime()
    }

    func cancelObservers() {
        cancellable.forEach { $0.cancel() }
    }

    private func observeRemainingTime() {
        mediaPlayer
            .publisher(for: \.remainingTime, options: [.new])
            .sink { remainingTime in
                if let remainingTime, let _ = remainingTime.value {
                    self.durationString = remainingTime.stringValue
                }
            }
            .store(in: &cancellable)
    }

    private func observeTimeElapsed() {
        mediaPlayer
            .publisher(for: \.time, options: [.new])
            .sink { time in
                print("Time: \(time)")
            }
            .store(in: &cancellable)
    }

    // MARK: - Helpers

    var isPlaying: Bool {
        return playerState == .playing
    }

    var duration: Int {
        guard let lengthInMilliseconds = mediaLength?.intValue else {
            return 0
        }

        let msToSeconds = lengthInMilliseconds / 1000
        return Int(msToSeconds)
    }
    
    var formattedDuration: String {
        return mediaLength?.stringValue ?? "--:--"
    }

    func setTrackDuration() {
        self.durationString = formattedDuration
    }

    // MARK: - VLCKit Related

    private var mediaLength: VLCTime? {
        guard let nowPlusFive = Calendar.current.date(byAdding: .second,
                                                      value: 5,
                                                      to: Date()),
              let length = self.mediaPlayer.media?.lengthWait(until: nowPlusFive) else {
            return nil
        }
        return length
    }
}
