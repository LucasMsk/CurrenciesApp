//
//  Currency.swift
//  CurrenciesApp
//
//  Created by luca on 08/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation

struct Currency: Codable  {
    let currency :String
    let code :String
    let mid :Float?
    let bid :Float?
    let ask :Float?
}

struct CurrenciesList: Codable  {
    let table :String
    let effectiveDate :String
    let rates :[Currency]
}
