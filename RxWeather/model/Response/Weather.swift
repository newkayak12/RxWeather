//
//  Weather.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
