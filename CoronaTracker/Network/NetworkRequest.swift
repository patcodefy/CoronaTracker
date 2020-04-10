//
//  NetworkRequest.swift
//  CoronaTracker
//
//  Created by pat on 4/10/20.
//  Copyright © 2020 pat. All rights reserved.
//

import Foundation
class NetworkRequest {
    private var countryCode: String
    init(countryCode: String = "") {
        self.countryCode = countryCode
    }
    
    func getCountryData(completionHandler: @escaping(Countrydata?) ->Void) {
        if self.countryCode != "" {
            let decoder = JSONDecoder()
            let url = URL(string: "https://thevirustracker.com/free-api?countryTotal=\(self.countryCode)")!
            print (url)
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                guard let results = try? decoder.decode(Response.self, from: data) else {return}
                print (results.countrydata.first!)
                DispatchQueue.main.async {
                    completionHandler(results.countrydata.first!)
                }
            }
            task.resume()
        }
    }
    
    func getGlobalData(completionHandler: @escaping(GlobalResults) ->Void)  {
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.thevirustracker.com/free-api?global=stats")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {return}
            guard let results = try? decoder.decode(GlobalResponse.self, from: data) else {return}
            DispatchQueue.main.async {
                completionHandler(results.results.first!)
            }
        }
        task.resume()
    }
}
