//
//  HomePage.swift
//  Smart parking
//
//  Created by Tuan Nguyen on 2/23/22.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            HStack() {
                Image("smartpark")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                NavigationLink(destination: ParkingLot()) {
                    Text("Start")
                        .fontWeight(.bold)
                        .padding()
                        .font(.largeTitle)
                    }
                
                NavigationLink(destination: AboutPage()) {
                    AboutButton()
                }
            }
        }
    }
}
