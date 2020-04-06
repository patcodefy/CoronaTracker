//
//  GlobalResult.swift
//  CoronaTracker
//
//  Created by pat on 4/5/20.
//  Copyright © 2020 pat. All rights reserved.
//

import Foundation
struct GlobalResults: Codable {
    let total_cases: Int
    let total_recovered: Int
    let total_unresolved: Int
    let total_deaths: Int
    let total_new_cases_today: Int
    let total_new_deaths_today: Int
    let total_active_cases: Int
    let total_serious_cases: Int
    let total_affected_countries: Int
    var data: [StatsCellData]{
        get {
            return [
                StatsCellData (
                    title: "total cases", stats: total_cases
                ),
                StatsCellData (
                    title: "total recovered", stats: total_recovered
                ),
                StatsCellData (
                    title: "total unresolved", stats: total_unresolved
                ),
                StatsCellData (
                    title: "total deaths", stats: total_deaths
                ),
                StatsCellData (
                    title: "new cases", stats: total_new_cases_today
                ),
                StatsCellData (
                    title: "new deaths", stats: total_new_deaths_today
                ),
                StatsCellData (
                    title: "active cases", stats: total_active_cases
                ),
                StatsCellData (
                    title: "serious cases", stats: total_serious_cases
                ),
                StatsCellData (
                    title: "affected countries", stats: total_affected_countries
                ),
            ]
        }
    }
}
