//
//  ParkingLayout.swift
//  Smart parking
//
//  Created by Trong Van  on 10/19/21.
//

import SwiftUI

//--------------------Global variables for Colors ------------------------
class GlobalColor {
    var parkNotTaken: Color = Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.3800349181))
    var parkTaken: Color = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var parkNotActive: Color = Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1))
    var dirtColor: Color = Color(#colorLiteral(red: 0.5921568627, green: 0.4705882353, blue: 0.2431372549, alpha: 1))
    var parkingColor: Color = Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1))
    var parkingLineColor: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var parkingCurbColor: Color = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
}

struct ParkingLot: View {
    var globalColor = GlobalColor()
    let sideCurbWidth = 8
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let parkSizeWidth = CGFloat(geometry.size.width)
                let parkSizeHeight = CGFloat(geometry.size.height)
                HStack(spacing: 0){
                    HStack(spacing: 0){
                        VStack {
                            EmptyView()
                            Spacer()
                            Text("Side Walk")               //not dynamic enough
                                .lineLimit(2)
                                .foregroundColor(.black)
                                .font(.subheadline)
                            Spacer()
                            Setting()
                            //need to add notification for each parking lot
                            
                            
                            //Side Menu
                            //share button
                            //getting users input (emailing)
                            
                            
                            
                        }
                        .background(Color(#colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.7725490196, alpha: 1)))
                        .frame(width: parkSizeWidth * 0.07)
                        Rectangle()
                            .fill(globalColor.dirtColor)
                            .border(width: CGFloat(sideCurbWidth), edges: [.trailing], color: globalColor.parkingCurbColor)
                    }
                    .frame(width: parkSizeWidth * 0.13)
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(globalColor.dirtColor)
                                .frame(width: parkSizeWidth*0.13)
                                .cornerRadius(12, corners: [.topRight, .bottomRight])
                                .offset(x: CGFloat(sideCurbWidth) * -1)
                            Spacer()
                            Capsule()
                                .foregroundColor(globalColor.dirtColor)
                                .frame(width: parkSizeWidth*0.25)
                            Spacer()
                            Rectangle()
                                .foregroundColor(globalColor.dirtColor)
                                .frame(width: parkSizeWidth*0.13)
                                .cornerRadius(50, corners: [.topLeft, .bottomLeft])
                                .offset(x: CGFloat(sideCurbWidth))
                        }
                        .frame(height: parkSizeHeight * 0.10)
                        .background(globalColor.parkingColor)
                        HStack {
                            ParkingLayout(height: Double(parkSizeHeight * 0.9))
                        }
                        .frame(height: parkSizeHeight * 0.9)
                        .background(globalColor.parkingColor)
                    }
                    .background(globalColor.parkingColor)
                    .frame(width: parkSizeWidth * 0.8)
                    .zIndex(1)
                    HStack {
                        Rectangle()
                            .frame(width: parkSizeWidth * 0.07)
                            .foregroundColor(globalColor.dirtColor)
                            .border(width: CGFloat(sideCurbWidth), edges: [.leading], color: globalColor.parkingCurbColor)
                    }
                }
                .frame(width: parkSizeWidth, height: parkSizeHeight)
            }
            .ignoresSafeArea()
        }
    }
}


extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    func landscape() -> some View {
        self.modifier(LandscapeModifier())
    }
}
struct EdgeBorder: Shape {
    
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }
            
            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }
            
            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }
            
            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct LandscapeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .previewLayout(.fixed(width: 812, height: 375))
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingLot()
            .previewDevice("iPhone 11 Pro")
            .previewDisplayName("iPhone 12 Pro")
            .landscape()
    }
}

