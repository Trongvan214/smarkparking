//
//  ParkingSpot.swift
//  Smart parking
//
//  Created by Trong Van  on 11/6/21.
//

import SwiftUI

struct ParkingSpot: View {
    var width: Double
    var height: Double
    var isActive: Bool
    var isTaken: Bool
    let border: [Edge]
    init(width: Double, isActive: Bool, isTaken: Bool, border: [Edge]) {
        self.width = width
        self.isTaken = isTaken
        self.isActive = isActive
        self.height = width * 2.2
        self.border = border
    }
    var body: some View {
        if(!isActive) {
            SpotNotAvailble(width: width, height: height)
                .border(width: 3, edges: border, color: .white)
        }
        else if(!isTaken){
            SpotNotTaken(width: width, height: height)
                .border(width: 3, edges: border, color: .white)
        } else {
            SpotTaken(width: width, height: height)
                .border(width: 3, edges: border, color: .white)
        }
    }
}

struct SpotNotAvailble: View {
    var width: Double
    var height: Double
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1)))
            .frame(width: CGFloat(height), height: CGFloat(width))
    }
}
struct SpotNotTaken: View {
    var width: Double
    var height: Double
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.3800349181)))
            .frame(width: CGFloat(height), height: CGFloat(width))
    }
}
struct SpotTaken: View {
    var width: Double
    var height: Double
    var body: some View {
        Rectangle()
            .foregroundColor(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
            .frame(width: CGFloat(height), height: CGFloat(width))
    }
}
