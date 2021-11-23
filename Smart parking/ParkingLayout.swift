//
//  ParkingLot.swift
//  Smart parking
//
//  Created by Trong Van  on 11/6/21.
//

import SwiftUI

//func sendRequest(_ completion: @escaping (String) -> ()) {
//    guard let url = URL(string: "http://10.50.208.17:9090/api/plugins/telemetry/DEVICE/1211cf00-3350-11ec-b020-4fe1b95b4375/values/timeseries?useStrictDataTypes=false") else
//    {
//        return
//    }
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6NDc3dzQ3NUB3aWNoaXRhLmVkdSIsInNjb3BlcyI6WyJURU5BTlRfQURNSU4iXSwidXNlcklkIjoiZGU2NjczNzAtMzM0Yy0xMWVjLWIwMjAtNGZlMWI5NWI0Mzc1IiwiZmlyc3ROYW1lIjoiUGhvbmciLCJsYXN0TmFtZSI6IlZvIiwiZW5hYmxlZCI6dHJ1ZSwiaXNQdWJsaWMiOmZhbHNlLCJ0ZW5hbnRJZCI6ImI4NGZlNDEwLTMzNGItMTFlYy1iMDIwLTRmZTFiOTViNDM3NSIsImN1c3RvbWVySWQiOiIxMzgxNDAwMC0xZGQyLTExYjItODA4MC04MDgwODA4MDgwODAiLCJpc3MiOiJ0aGluZ3Nib2FyZC5pbyIsImlhdCI6MTYzNzU0ODE4NSwiZXhwIjoxNjM3NTU3MTg1fQ.3IVAAWFR5J_0LvFDriOcFN5bj-U15DAvtjmKbUGr1K2QX_UJiiT8mqtP_zOv6H_iXYr2yOrNaioOWxrBUoq5Hg", forHTTPHeaderField: "X-Authorization")
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//        guard error == nil else { print(error!.localizedDescription); return }
//        guard let data = data else { print("Empty data"); return }
//
//        if let str = String(data: data, encoding: .utf8) {
//            completion(str)
//        }
//    }.resume()
//}

func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.data(using: .utf8) {
     do {
        let myJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]?
         return myJson
         
    } catch let error {
           print(error)
    }
   }
    return nil
}

func gatherParkingLots() -> [Int: [String: Bool]] {
    var parkingSpots: [Int: [String: Bool]] = [
        1: ["nsx-arduino": true],
        2: ["mr2-arduino": true],
        3: ["supra-arduino": true]
    ]
    
    let url = URL(string: "http://10.50.208.17:9090/api/plugins/telemetry/DEVICE/1211cf00-3350-11ec-b020-4fe1b95b4375/values/timeseries?useStrictDataTypes=false")
    
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6NDc3dzQ3NUB3aWNoaXRhLmVkdSIsInNjb3BlcyI6WyJURU5BTlRfQURNSU4iXSwidXNlcklkIjoiZGU2NjczNzAtMzM0Yy0xMWVjLWIwMjAtNGZlMWI5NWI0Mzc1IiwiZmlyc3ROYW1lIjoiUGhvbmciLCJsYXN0TmFtZSI6IlZvIiwiZW5hYmxlZCI6dHJ1ZSwiaXNQdWJsaWMiOmZhbHNlLCJ0ZW5hbnRJZCI6ImI4NGZlNDEwLTMzNGItMTFlYy1iMDIwLTRmZTFiOTViNDM3NSIsImN1c3RvbWVySWQiOiIxMzgxNDAwMC0xZGQyLTExYjItODA4MC04MDgwODA4MDgwODAiLCJpc3MiOiJ0aGluZ3Nib2FyZC5pbyIsImlhdCI6MTYzNzYzMzI2OSwiZXhwIjoxNjM3NjQyMjY5fQ.3eK7f2pLf6oRDqfpeSxfQhOEDmy4RVnNhezc3Wrw_CutVt26xwGZPswgiJhtinyIxu4aFbjCgH2JsLqUZjq67Q", forHTTPHeaderField: "X-Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
    
            if let str = String(data: data, encoding: .utf8) {
                let jsonDict = convertStringToDictionary(text: str)
                print(jsonDict!["data_payload"])
                let data_payload = jsonDict!["data_payload"]
                if ((data_payload?.contains("FALSE")) != nil) {
                    print("nsx-arduino parking space is false")
                }
            }
        }.resume()
    
    return parkingSpots
}

struct ParkingLayout: View {
    var globalColor = GlobalColor()
    
    var parkingSpots: [Int: [String: Bool]] = gatherParkingLots()
    
    let parkSpotHeight: Double
    let height: Double
    let bottomPadding: Double = 10
    init(height: Double){
        self.height = height
        self.parkSpotHeight = (height-bottomPadding) / 10
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

