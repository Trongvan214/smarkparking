//
//  ParkingColumn.swift
//  Smart parking
//
//  Created by Trong Van  on 11/7/21.
//

import SwiftUI

struct ParkingColumn: View {
    var spots: [Int: [String: Bool]]
    let parkSpotHeight: Double
    var border: [Edge]
    var topBorder: Bool = false                                 //default value if property isn't given
    var body: some View {
        VStack(spacing: 0){
            let sortedSpotKeys = Array(spots.keys).sorted(by: <)           //sort of the dictionary, it comes unsorted
            ForEach(Array(sortedSpotKeys.enumerated()), id: \.1) { index, key -> ParkingSpot in
                let isActive = !(spots[key]!.keys.contains("-"))       //check to see if [String] has "-" then return (true/false)
                let isTaken = spots[key]!.values.contains(true)        //check to see if [Bool] has true? then return (true/false)
                if (topBorder && index == 0) {
                    var newBorder: [Edge] = border
                    newBorder.append(.top)
                    return ParkingSpot(width: parkSpotHeight, isActive: isActive, isTaken: isTaken, border: newBorder)
                } else {
                    return ParkingSpot(width: parkSpotHeight, isActive: isActive, isTaken: isTaken, border: border)
                }
            }
            Spacer()                //keep everything push up
        }
    }
}

