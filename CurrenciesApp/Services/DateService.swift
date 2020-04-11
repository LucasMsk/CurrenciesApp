//
//  DateService.swift
//  CurrenciesApp
//
//  Created by luca on 09/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation

struct DateService {
    let format = DateFormatter()
    
    init() {
        format.dateFormat = "YYYY-MM-dd"
    }
    func dateToStr(_ date: Date) -> String {
        return format.string(from: date)
    }
    func strToDate(_ dateStr: String) -> Date {
        return format.date(from: dateStr) ?? Date()
    }
}
