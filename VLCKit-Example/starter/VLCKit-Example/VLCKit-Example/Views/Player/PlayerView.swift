//
//  PlayerView.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    var body: some View {
        VStack {
            DurationView(duration: viewModel.durationString)
                .padding(.bottom)
            Button {
                viewModel.togglePlayerState()
            } label: {
                HStack {
                    Image(systemName: viewModel.controlIconName)
                        .padding(.trailing, 4)
                    Text(viewModel.controlButtonTitle)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(PlayerButtonStyle(
                backgroundColor: Color("primary"),
                foregroundColor: .black))
        }
        .padding()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTrack = Track(filePath: AudioTracks.sampleFilePath1)

        PlayerView(
            viewModel: PlayerViewModel(track: sampleTrack)
        )
    }
}
