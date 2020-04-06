//
//  GlobalResponse.swift
//  CoronaTracker
//
//  Created by pat on 4/5/20.
//  Copyright © 2020 pat. All rights reserved.
//

import Foundation
struct GlobalResponse: Codable {
    let results: [GlobalResults]
    let stat: String
}
