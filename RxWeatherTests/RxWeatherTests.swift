//
//  RxWeatherTests.swift
//  RxWeatherTests
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import XCTest
@testable import RxWeather

final class RxWeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        print(Bundle.main.url(forResource: "application", withExtension: "json"))
    }
    
    func testService() {
        let city = City(name: "Seoul")
        async {
            await print(Service.shared.get(city: city))
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
