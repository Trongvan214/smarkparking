//
//  ParkingLayout.swift
//  Smart parking
//
//  Created by Trong Van  on 10/19/21.
//

import SwiftUI


struct ParkingLayout: View {
    let dirtColor: Color = Color(#colorLiteral(red: 0.5921568627, green: 0.4705882353, blue: 0.2431372549, alpha: 1))
    let parkingColor: Color = Color(#colorLiteral(red: 0.4470588235, green: 0.4235294118, blue: 0.3294117647, alpha: 1))
    let sideCornerWidth = 7
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let parkSizeWidth = CGFloat(geometry.size.width)
                let parkSizeHeight = CGFloat(geometry.size.height)
                HStack(spacing: 0){
                    HStack(spacing: 0){
                        Rectangle()
                            .frame(width: parkSizeWidth * 0.1)
                            .foregroundColor(dirtColor)
                            .border(width: CGFloat(sideCornerWidth), edges: [.trailing], color: .white)
                    }
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(dirtColor)
                                .frame(width: parkSizeWidth*0.13)
                                .cornerRadius(50, corners: [.topRight, .bottomRight])
                                .offset(x: CGFloat(sideCornerWidth) * -1)
                            Spacer()
                            Capsule()
                                .foregroundColor(dirtColor)
                                .frame(width: parkSizeWidth*0.25)
                            Spacer()
                            Rectangle()
                                .foregroundColor(dirtColor)
                                .frame(width: parkSizeWidth*0.13)
                                .cornerRadius(50, corners: [.topLeft, .bottomLeft])
                                .offset(x: CGFloat(sideCornerWidth))
                        }
                        .frame(height: parkSizeHeight * 0.10)
                        .background(parkingColor)
                        HStack {
                            ParkingLot(height: Double(parkSizeHeight * 0.9))
                        }
                        .frame(height: parkSizeHeight * 0.9)
                        .background(parkingColor)
                    }
                    .background(parkingColor)
                    .frame(width: parkSizeWidth * 0.8)
                    .zIndex(1)
                    HStack {
                        Rectangle().frame(width: parkSizeWidth * 0.1)
                            .foregroundColor(dirtColor)
                            .border(width: CGFloat(sideCornerWidth), edges: [.leading], color: .white)
                    }
                }
                .frame(width: parkSizeWidth, height: parkSizeHeight)
            }
            .ignoresSafeArea()
            .background(dirtColor)
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
extension View {
    func landscape() -> some View {
        self.modifier(LandscapeModifier())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingLayout()
            .previewDevice("iPhone 11 Pro")
            .previewDisplayName("iPhone 12 Pro")
            .landscape()
    }
}

