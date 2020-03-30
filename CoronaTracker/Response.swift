//
//  Response.swift
//  CoronaTracker
//
//  Created by pat on 3/29/20.
//  Copyright © 2020 pat. All rights reserved.
//

import SwiftUI
struct Response: Codable {
    var countrydata: [Countrydata]
    let stat: String
}
