//
//  DurationView.swift
//  VLCKit-Example
//
//  Created by Ajith on 19/09/22.
//

import SwiftUI

struct DurationView: View {
    var duration: String

    var body: some View {
        Text(duration)
            .font(.system(size: 64.0))
            .padding()
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView(duration: "11:36")
    }
}
