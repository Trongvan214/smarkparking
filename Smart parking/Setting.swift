//
//  Setting.swift
//  Smart parking
//
//  Created by Trong Van  on 11/13/21.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        ZStack {
            Image(systemName: "gearshape.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
        }
        .padding()
        .zIndex(1000)
    }
}
