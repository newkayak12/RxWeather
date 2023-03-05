//
//  Response.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
struct Response: Codable {
    var coord: Coordinate
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Cloud
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    
//    init(from decoder: Decoder) throws {
//        
//    }
}
