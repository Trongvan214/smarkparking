//
//  Legend.swift
//  Smart parking
//
//  Created by Trong Van  on 11/12/21.
//

import SwiftUI

struct Legend: View {
    var globalColor = GlobalColor()
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Key")
                        .font(.headline)
                        .padding(.bottom, 2)
                }
                LegendElement(color: globalColor.parkTaken, text: "Taken")
                LegendElement(color: globalColor.parkNotTaken, text: "Not Taken")
                LegendElement(color: globalColor.parkNotActive, text: "Not Applicable")
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .border(Color.yellow, width: 2)
            
        }
        .background(Color.white)
        .clipped()
        .shadow(color: Color.yellow, radius: 4, x: 0, y: 0)
    }
}

struct LegendElement: View {
    var color: Color
    var text: String
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 25, height: 25, alignment: .leading)
                .padding(.all, 4)
            Text(text)
                .font(.footnote)
            Spacer()
        }
    }
}
