//
//  Sys.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
struct Sys: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}
