//
//  ViewModelType.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
protocol ViewModelType{
    var service: Service  {get set}
    var log: Log  {get set}
    var title: String {get set}
}
