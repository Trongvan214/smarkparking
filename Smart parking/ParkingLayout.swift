//
//  ParkingLot.swift
//  Smart parking
//
//  Created by Trong Van  on 11/6/21.
//

import SwiftUI

class ParkingData {
    @Published var parkingSpots: [Int: [String: Bool]] = [
        1: ["nsx-arduino": true],
        2: ["mr2-arduino": true],
        3: ["supra-arduino": true],
        4: ["1b823b46-5460-4e85-ad1c-96e8d442e3e3": false],
        5: ["-": true],
        6: ["fae206b8-b272-4106-a2d4-a06530c7cb3a": false],
        7: ["1e636ce8-aba3-49b3-8c7a-b5b3feb2e645": true],
        8: ["-": true],
        9: ["81a558c7-5f09-4b41-a34b-20e2c20305b0": true],
        10: ["-": true],
        11: ["81a558c7-5f09-4b41-a34b-20e2c20305b0": true],
        12: ["667fe2d3-f959-42d4-ad32-ce0d91221172": false],
        13: ["c0ab17b0-0c1a-40ee-9d83-a70a4e79d6a1": false],
        14: ["6073a040-7dc2-41fa-8faf-b5a79d5fc957": false],
        15: ["0a5b7371-7e0c-47bd-bca7-23aabddd404f": false],
        16: ["d1b4f5be-4046-4617-8a9f-829e538028c9": false],
        17: ["93eeb415-3a39-4833-899c-43062ee6d4b7": false],
        18: ["-": false],
        19: ["095e3a89-c450-4957-84e5-47673c7899ff": false],
        20: ["b38d7147-c068-49a6-91c4-41bfd6b1d6ab": false],
        21: ["88d2a54f-0abe-42a1-93bf-d5fecdd594ef": false],
        22: ["d1789e83-b890-48b8-a2ca-1be42b93bfe8": false],
        23: ["934a5419-1e86-4535-91d0-c7f0de452e1a": false],
        24: ["21a58205-6485-4d2b-832b-93c7674d8946": false],
        25: ["b921c4e2-ac16-4ff7-8fa0-5080b869b0bc": false],
        26: ["1738b8b6-375e-40aa-bbac-a4727f031caa": false],
        27: ["08fa9c48-1d1d-4c5c-9796-8f03ba8b3fcc": false],
        28: ["08fa9c48-1d1d-4c5c-9796-8f03ba8b3fcc": false],
        29: ["08fa9c48-1d1d-4c5c-9796-8f03ba8b3fcc": false],
        30: ["d1b4f5be-4046-4617-8a9f-829e538028c9": false],
        31: ["08fa9c48-1d1d-4c5c-9796-8f03ba8b3fcc": false],
        32: ["-": false],
        33: ["-": false],
        34: ["-": false],
        35: ["-": false],
        36: ["-": false],
        37: ["-": false],
        38: ["-": false]
    ]
    func update(id: String, value: Bool){
        for key in parkingSpots.keys {
            let parkingId = self.parkingSpots[key]!.keys
            if(parkingId.contains(id)){
                self.parkingSpots[key]!.updateValue(value, forKey: id)
            }
        }
    }
    
}

struct Parking: Codable, Hashable {
    var ts: String
    var value: String
}

struct ParkingLayout: View {
    var globalColor = GlobalColor()
    let network = Network()
    @State var parkingSpots = ParkingData().parkingSpots
    let parkSpotHeight: Double
    let height: Double
    let bottomPadding: Double = 10
    init(height: Double){
        self.height = height
        self.parkSpotHeight = (height-bottomPadding) / 10
        network.getParkingLots()
    }
    var body: some View {
        HStack {
            let leftSpots = parkingSpots.filter{ $0.0 <= 10 }                       //spots 1 to 10
            let midLeftSpots = parkingSpots.filter{ ($0.0 <= 19 && $0.0 > 10) }     //spots 11 to 19
            let midRightSpots = parkingSpots.filter{ ($0.0 <= 28 && $0.0 > 19) }    //spots 20 to 28
            let rightSpots = parkingSpots.filter{ ($0.0 <= 38 && $0.0 > 28) }       //spots 29 to 38
            
            //------------------------------Left side----------------------------------
            ParkingColumn(spots: leftSpots, parkSpotHeight: parkSpotHeight, border: [.bottom])
            
            //-------------------------------Legend------------------------------------
            Spacer()
            
            Legend()
            
            Spacer()
            
            //---------------------------------Middle-------------------------------------
            VStack {
                Rectangle()                         //Space for traveling cars (no parking)
                    .foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1)))
                    .zIndex(-1)
                    .frame(width: CGFloat(parkSpotHeight) * 2.2)
                HStack(spacing: 0) {
                    ParkingColumn(spots: midLeftSpots, parkSpotHeight: parkSpotHeight, border: [.bottom, .trailing], topBorder: true)
                    ParkingColumn(spots: midRightSpots, parkSpotHeight: parkSpotHeight, border: [.bottom], topBorder: true)
                }
            }
            
            //-----------------------------Invisible container---------------------------------
            Spacer()
            VStack() {                    //help aligns and make things symmetric
                Rectangle().foregroundColor(Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1)))
            }
            Spacer()
            
            //-------------------------------Right side ------------------------------------
            ParkingColumn(spots: rightSpots, parkSpotHeight: parkSpotHeight, border: [.bottom])
        }
    }
}

