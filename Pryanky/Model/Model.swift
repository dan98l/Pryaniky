//
//  Model.swift
//  Pryanky
//
//  Created by Daniil G on 14.10.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import Foundation

struct Pryaniky: Decodable {
   let data: [DateArray]
   let view: [String]
}

struct DateArray: Decodable {
   let name: String
   let data: Info
}

struct Info: Decodable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
