//
//  Service.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation
import RxSwift
import Alamofire


class Service {
    private let apiKey: String
    private let af: Session
    
    
    public static let shared = {
       return Service()
    }()
    
    private init(){
        var application: Application?
        guard let path = Bundle.main.url(forResource: "application", withExtension: "json") else {fatalError()}
        do {
            let data = try Data(contentsOf: path)
            application = try JSONDecoder().decode(Application.self, from: data)
        } catch {
            fatalError()
        }
        
        guard let application = application else { fatalError() }
        apiKey = application.apiKey
        af = AF
    }
    
    func get(city: City) -> Observable<Response>{
        return  Observable
            .create { [unowned self] ob in
            
                let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city.name)&units=metric&lang=kr&appid=\(self.apiKey)"
                let response = af.request(url, method: .get)
                                 .responseDecodable(of: Response.self){ response in
                                    switch response.result {
                                        case .success(let response) :
                                            ob.onNext(response)
                                        case .failure(let error):
                                            ob.onError(error)
                                    }
                                 }
            
                return Disposables.create {
                    response.cancel()
                }
        }
    }
    func icon(iconNumber: String) -> Observable<Data>{
        var url = "https://openweathermap.org/img/wn/\(iconNumber)@2x.png"
        return Observable.create { [unowned self] ob in
            var response = af.request(url, method: .get)
                .responseData { response in
                    switch response.result {
                        case .success(let response) :
                            ob.onNext(response)
                        case .failure(let error) :
                            ob.onError(error)
                    }
                }
            
            return Disposables.create{
                response.cancel()
            }
            
        }
    }
    
}


