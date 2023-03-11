//
//  Log.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import Foundation

enum LogLevel: Int {
    case INFO = 0
    case DEBUG
    case WARN
    case FATAL
    
}
protocol Logger {
    var level: LogLevel {get set}
    func info(of: Any...)
    func debug(of: Any...)
    func warn(of: Any...)
    func fatal(of: Any...)
}

struct Log: Logger {
    var level: LogLevel = .INFO
    static var share = {
        var application: Application?
        guard let path = Bundle.main.url(forResource: "application", withExtension: "json") else {fatalError()}
        do {
            let data = try Data(contentsOf: path)
            application = try JSONDecoder().decode(Application.self, from: data)
        } catch {
            fatalError()
        }
        
        guard let application = application else { fatalError() }
        var rawValue = 0
        switch (application.logLevel) {
            case "INFO":
                rawValue = 0;
            case "DEBUG":
                rawValue = 1;
            case "WARN":
                rawValue = 2;
            case "FATAL":
                rawValue = 3;
            default:
                break;
        }
       return Log(level: LogLevel(rawValue: rawValue) ?? .INFO)
    }()


    private init(level: LogLevel) {
        self.level = level
    }
    
    
    func info(of: Any...) {
        if level.rawValue > LogLevel.INFO.rawValue { return }
        print("🟦 ::: \(DateFormatter().string(from: Date())) >", of)
    }
    
    func debug(of: Any...) {
        if level.rawValue > LogLevel.DEBUG.rawValue { return }
        print("🟩 ::: \(DateFormatter().string(from: Date())) >", of)
    }
    
    func warn(of: Any...) {
        if level.rawValue > LogLevel.WARN.rawValue { return }
        print("🟧 ::: \(DateFormatter().string(from: Date())) >", of)
    }
    
    func fatal(of: Any...) {
        if level.rawValue > LogLevel.FATAL.rawValue { return }
        print("🟥 ::: \(DateFormatter().string(from: Date())) >", of)
    }
}
