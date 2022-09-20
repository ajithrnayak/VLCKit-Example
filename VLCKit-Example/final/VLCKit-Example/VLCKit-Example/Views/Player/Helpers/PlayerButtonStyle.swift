//
//  PlayerButtonStyle.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import SwiftUI

struct PlayerButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.clear)
            )
            .padding([.top, .bottom], 10)
            .font(.system(size: 18.0,weight: .medium))
    }
}
