//
//  ApiRequest.swift
//  Smart parking
//
//  Created by Phong Vo on 11/21/21.
//

import SwiftUI

Struct ApiRequest {
    func sendRequest(_ completion: @escaping (String) -> ()) {
        guard let url = URL(string: "http://10.50.208.17:9090/api/plugins/telemetry/DEVICE/1211cf00-3350-11ec-b020-4fe1b95b4375/values/timeseries?useStrictDataTypes=false") else
        {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ6NDc3dzQ3NUB3aWNoaXRhLmVkdSIsInNjb3BlcyI6WyJURU5BTlRfQURNSU4iXSwidXNlcklkIjoiZGU2NjczNzAtMzM0Yy0xMWVjLWIwMjAtNGZlMWI5NWI0Mzc1IiwiZmlyc3ROYW1lIjoiUGhvbmciLCJsYXN0TmFtZSI6IlZvIiwiZW5hYmxlZCI6dHJ1ZSwiaXNQdWJsaWMiOmZhbHNlLCJ0ZW5hbnRJZCI6ImI4NGZlNDEwLTMzNGItMTFlYy1iMDIwLTRmZTFiOTViNDM3NSIsImN1c3RvbWVySWQiOiIxMzgxNDAwMC0xZGQyLTExYjItODA4MC04MDgwODA4MDgwODAiLCJpc3MiOiJ0aGluZ3Nib2FyZC5pbyIsImlhdCI6MTYzNzU0ODE4NSwiZXhwIjoxNjM3NTU3MTg1fQ.3IVAAWFR5J_0LvFDriOcFN5bj-U15DAvtjmKbUGr1K2QX_UJiiT8mqtP_zOv6H_iXYr2yOrNaioOWxrBUoq5Hg", forHTTPHeaderField: "X-Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }

            if let str = String(data: data, encoding: .utf8) {
                completion(str)
            }
        }.resume()
    }
}
