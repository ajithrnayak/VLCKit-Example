//
//  ContentView.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import SwiftUI

struct ContentView: View {

    var albumArtView: some View {
        ZStack {
            Image(systemName: "waveform")
                .font(.system(size: 250))
                .foregroundColor(Color("secondary"))

            Image(systemName: "waveform")
                .font(.system(size: 250))
                .foregroundColor(Color("primary"))
                .offset(x: -5, y: -5)
        }
    }

    var body: some View {
        VStack {
            albumArtView
            Spacer()
            PlayerView(
                viewModel: PlayerViewModel(
                    track: Track(filePath: AudioTracks.sampleFilePath1)
                )
            )
        }
        .padding(.top, 40.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
