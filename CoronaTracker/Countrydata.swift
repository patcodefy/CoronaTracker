//
//  CountryData.swift
//  CoronaTracker
//
//  Created by pat on 3/29/20.
//  Copyright © 2020 pat. All rights reserved.
//

import SwiftUI
struct Countrydata: Codable {
    
    let info: Info
    let total_cases: Int
    let total_recovered: Int
    let total_unresolved: Int
    let total_deaths: Int
    let total_new_cases_today: Int
    let total_new_deaths_today: Int
    let total_active_cases: Int
    let total_serious_cases: Int
}
