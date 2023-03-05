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
    
    func get(city: City) -> Response?{
        var res: Response?
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city.name)&units=metric&lang=kr&appid=\(apiKey)"
        
        af.request(url, method: .get)
          .responseDecodable(of: Response.self){ response in
              switch response.result {
                  case .success(let response) :
                      res = response
                  case .failure(let error):
                      print(error)
                      res = nil
              }
          }
        
        return res;
    }
    
}

struct Application: Decodable {
    var apiKey: String
}
