//
//  Detail.swift
//  CurrenciesApp
//
//  Created by luca on 10/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation

struct Detail: Codable, Identifiable  {
    let id = UUID()
    let effectiveDate :String
    let mid :Float?
    let bid :Float?
    let ask :Float?
}

struct DetailList: Codable  {
    let rates :[Detail]
}
