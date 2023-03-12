//
//  DetailView.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import UIKit
import RxSwift
import NSObject_Rx

final class DetailView: BaseViewController, ViewModelBindable {
    let container: UIStackView = UIStackView(frame: .zero)
    let image: UIImageView = UIImageView(image: UIImage(named: "logo"))
    
    let weatherContainer: UIStackView = UIStackView(frame: .zero)
    let weatherLabel: UILabel = UILabel(frame: .zero)
    
    let temperatureContainer = UIStackView(frame: .zero)
    let temperature = UILabel(frame: .zero)
    let min = UILabel(frame: .zero)
    let max = UILabel(frame: .zero)
    let feelsLike = UILabel(frame: .zero)
    
    let pressureAndHumidityContainer = UIStackView(frame: .zero)
    let pressure = UILabel(frame: .zero)
    let humidity = UILabel(frame: .zero)
    
    let sunStateContainer = UIStackView(frame: .zero)
    let sunrise = UILabel(frame: .zero)
    let sunset = UILabel(frame: .zero)
    
    var viewModel: DetailViewModel!
    func bindViewModel() {
        viewModel.setData()
    }
    func initializeUI() {
        weatherLabel.text = "-"
        temperature.text = "기온 : - ℃"
        min.text = "최저 : - ℃"
        max.text = "최고 : - ℃"
        feelsLike.text = "체감온도 : - ℃"
        pressure.text = "기압 : - hPa"
        humidity.text = "습도 : - %"
        sunrise.text = "일출 : -"
        sunset.text = "일몰 : -"
    }
    func setUI() {
        initializeUI()
        view.backgroundColor = .systemBackground
        viewModel.response.subscribe{ [unowned self] data in
            self.viewModel.log.warn(of: data)
        }.disposed(by: rx.disposeBag)
        Observable.just(viewModel.title).bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
        Observable.just("Search").bind(to: navigationItem.rx.backButtonTitle).disposed(by: rx.disposeBag)
        
        
        container.axis = .horizontal
        weatherContainer.axis = .vertical
        temperatureContainer.axis = .vertical
        pressureAndHumidityContainer.axis = .vertical
        sunStateContainer.axis = .vertical
        
        weatherContainer.distribution = .fillEqually
        temperatureContainer.distribution = .fillEqually
        pressureAndHumidityContainer.distribution = .fillEqually
        sunStateContainer.distribution = .fillEqually
        
        
        weatherContainer.addArrangedSubview(weatherLabel)
        temperatureContainer.addArrangedSubview(temperature)
        temperatureContainer.addArrangedSubview(min)
        temperatureContainer.addArrangedSubview(max)
        temperatureContainer.addArrangedSubview(feelsLike)
        pressureAndHumidityContainer.addArrangedSubview(pressure)
        pressureAndHumidityContainer.addArrangedSubview(humidity)
        sunStateContainer.addArrangedSubview(sunrise)
        sunStateContainer.addArrangedSubview(sunset)
        
        container.addArrangedSubview(image)
        container.addArrangedSubview(weatherContainer)
        container.addArrangedSubview(temperatureContainer)
        container.addArrangedSubview(pressureAndHumidityContainer)
        container.addArrangedSubview(sunStateContainer)
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
