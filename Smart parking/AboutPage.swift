//
//  AboutPage.swift
//  Smart parking
//
//  Created by Tuan Nguyen on 2/23/22.
//

import Foundation

import SwiftUI

struct AboutPage: View {
    var body: some View {
        ScrollView() {
            VStack() {
                Spacer()
                Text("About")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(10.0)
                Text("Smart Park is an application mainly implemented in school parking lots as well as parking lots for big events. The application will use a couple different sensors to tell whether a car is in a parking spot or not, then those sensors will communicate the data through a LoRa gateway and then to the backend and frontend of the application. The application will then show the user whether the spot is taken or not based on the color code, and people will be able to find open parking that way.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                Spacer()
                    .frame(height: 30)
                Text("Instructions")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(10.0)
                Text("Step 1. Click start")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                Text("Step 2. Click desired parking lot pin")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                Text("Step 3. Cross reference virtual parking lot with real parking lot to find open spots")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

