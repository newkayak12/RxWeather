//
//  Application.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/06.
//

import Foundation
struct Application: Decodable {
    var apiKey: String
    var logLevel: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey
        case logLevel = "log_level"
    }
}
