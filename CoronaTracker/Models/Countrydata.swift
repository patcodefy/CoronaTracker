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
    let total_danger_rank: Int
    var data: [StatsCellData] {
        get{
            return [
                StatsCellData(
                    title: "total cases",
                    stats: total_cases
                ),
                StatsCellData(
                    title: "total recovered",
                    stats: total_recovered
                ),
                StatsCellData(
                    title:"total unresolved",
                    stats:total_unresolved
                ),
                StatsCellData(
                    title:"total deaths",
                    stats: total_deaths
                ),
                StatsCellData(
                    title: "total new cases today",
                    stats: total_new_cases_today
                ),
                StatsCellData(
                    title:"total new deaths today",
                    stats:total_new_deaths_today
                ),
                StatsCellData(
                    title: "total active cases",
                    stats: total_active_cases
                ),
                StatsCellData(
                    title: "total serious cases",
                    stats:total_serious_cases
                ),
                StatsCellData(
                    title: "total danger rank",
                    stats: total_danger_rank
                )
            ]
            
        }
    }
}

