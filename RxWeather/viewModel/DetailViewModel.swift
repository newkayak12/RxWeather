//
//  DetailViewModel.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
import RxSwift

class DetailViewModel: ViewModelType {
    var service: Service
    var log: Log
    
    init(service: Service, log: Log) {
        self.service = service
        self.log = log
    }
}
