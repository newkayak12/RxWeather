//
//  DetailViewModel.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
import RxSwift
import NSObject_Rx

class DetailViewModel: ViewModelType {
    var title: String
    var service: Service
    var log: Log
    var city: City
    var response: PublishSubject<Response> = PublishSubject<Response>()
    var bag: DisposeBag = DisposeBag()
    
    init(title: String, service: Service, log: Log, city: City) {
        self.title = title
        self.service = service
        self.log = log
        self.city = city
    }
    public func setData(){
        log.warn(of: "???")
        service.get(city: self.city)
                .subscribe{ [unowned self ] data in
                    self.response.onNext(data)
                }
                .disposed(by: bag)
    }
}
