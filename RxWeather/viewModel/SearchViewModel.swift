//
//  SearchViewModel.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
import RxSwift

class SearchViewModel: ViewModelType {
    var title: String
    var log: Log
    var service: Service
    
    var responseList: [Response] = []
    
    init(title: String, service: Service, log: Log) {
        self.title = title
        self.service = service
        self.log = log
    }
}
