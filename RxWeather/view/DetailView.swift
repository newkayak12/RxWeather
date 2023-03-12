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
    
    let temperatureContainer1 = UIStackView(frame: .zero)
    let temperature = UILabel(frame: .zero)
    let feelsLike = UILabel(frame: .zero)
    let temperatureContainer2 = UIStackView(frame: .zero)
    let min = UILabel(frame: .zero)
    let max = UILabel(frame: .zero)
    
    let pressureAndHumidityContainer = UIStackView(frame: .zero)
    let pressure = UILabel(frame: .zero)
    let humidity = UILabel(frame: .zero)
    
    let sunStateContainer = UIStackView(frame: .zero)
    let sunRiseContainer = UIStackView(frame: .zero)
    let sunrise = UILabel(frame: .zero)
    
    let sunSetContainer = UIStackView(frame: .zero)
    let sunset = UILabel(frame: .zero)
    
    let format = DateFormatter()
    
    var viewModel: DetailViewModel!
    func bindViewModel() {
        
        viewModel.setData()
        viewModel.response.map{
            if $0.weather.count == 0  {return "-"}
            return $0.weather[0].description
        }.bind(to: weatherLabel.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "기온 : \($0.main.temp) ℃"
        }.bind(to: temperature.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "최저 : \($0.main.feelsLike) ℃"
        }.bind(to: feelsLike.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "최고 : \($0.main.tempMax) ℃"
        }.bind(to: max.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "체감온도 : \($0.main.tempMin) ℃"
        }.bind(to: min.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "기압 : \($0.main.pressure) hPa"
        }.bind(to: pressure.rx.text)
        .disposed(by: rx.disposeBag)

        viewModel.response.map{
            "습도 : \($0.main.humidity) %"
        }.bind(to: humidity.rx.text)
        .disposed(by: rx.disposeBag)
        
        viewModel.response
        .map { [unowned self] response in
            self.format.string(from: Date(timeIntervalSince1970: TimeInterval(response.sys.sunrise)))
        }
        .bind(to: sunrise.rx.text)
        .disposed(by: rx.disposeBag)
        
        viewModel.response
        .map { [unowned self] response in
            self.format.string(from: Date(timeIntervalSince1970: TimeInterval(response.sys.sunset)))
        }.bind(to: sunset.rx.text)
        .disposed(by: rx.disposeBag)
        
        
        viewModel.response
            .filter{ $0.weather.count > 0 }
            .subscribe{ [unowned self] response in
                self.viewModel.service
                    .icon(iconNumber: response.weather[0].icon)
                    .subscribe{ data in
                        self.image.image = UIImage(data: data)
                    }.disposed(by: rx.disposeBag)
            }.disposed(by: rx.disposeBag)
          
        
    }
    func initializeUI() {
        format.dateFormat = "HH시 mm분 ss일";
        weatherLabel.text = "-"
        temperature.text = "기온 : - ℃"
        min.text = "최저 : - ℃"
        max.text = "최고 : - ℃"
        feelsLike.text = "체감온도 : - ℃"
        pressure.text = "기압 : - hPa"
        humidity.text = "습도 : - %"
        sunrise.text = "일출 : -"
        sunset.text = "일몰 : -"
        
        weatherLabel.textAlignment = .center
        temperature.textAlignment = .center
        min.textAlignment = .center
        max.textAlignment = .center
        feelsLike.textAlignment = .center
        pressure.textAlignment = .center
        humidity.textAlignment = .center
        sunrise.textAlignment = .center
        sunset.textAlignment = .center
    }
    func setUI() {
        initializeUI()
        view.backgroundColor = .systemBackground
        viewModel.response.subscribe{ [unowned self] data in
            self.viewModel.log.warn(of: data)
        }.disposed(by: rx.disposeBag)
        Observable.just(viewModel.title).bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
        Observable.just("Search").bind(to: navigationItem.rx.backButtonTitle).disposed(by: rx.disposeBag)
        
        
        container.axis = .vertical
        weatherContainer.axis = .horizontal
        temperatureContainer1.axis = .horizontal
        temperatureContainer2.axis = .horizontal
        pressureAndHumidityContainer.axis = .horizontal
        sunStateContainer.axis = .horizontal
        sunRiseContainer.axis = .vertical
        sunSetContainer.axis = .vertical
        
        container.distribution = .fillEqually
        weatherContainer.distribution = .fillEqually
        temperatureContainer1.distribution = .fillEqually
        temperatureContainer2.distribution = .fillEqually
        pressureAndHumidityContainer.distribution = .fillEqually
        sunStateContainer.distribution = .fillEqually
        
        image.contentMode = .scaleAspectFit
        image.snp.makeConstraints { make in
            make.height.equalTo(100)
//            make.height.equalTo(200)
        }
//        weatherContainer.snp.makeConstraints { make in
//            make.height.equalTo(50)
//        }
//        temperatureContainer1.snp.makeConstraints { make in
//            make.height.equalTo(50)
//        }
//        pressureAndHumidityContainer.snp.makeConstraints { make in
//            make.height.equalTo(50)
//        }
//        sunStateContainer.snp.makeConstraints { make in
//            make.height.equalTo(50)
//        }
        
        weatherContainer.addArrangedSubview(weatherLabel)
        temperatureContainer1.addArrangedSubview(temperature)
        temperatureContainer1.addArrangedSubview(feelsLike)
        temperatureContainer2.addArrangedSubview(min)
        temperatureContainer2.addArrangedSubview(max)
        pressureAndHumidityContainer.addArrangedSubview(pressure)
        pressureAndHumidityContainer.addArrangedSubview(humidity)
        
        
        let riseLabel = UILabel(frame: .zero)
        riseLabel.textAlignment = .center
        riseLabel.text = "일출"
        let setLabel = UILabel(frame: .zero)
        setLabel.textAlignment = .center
        setLabel.text = "일몰"
        
        sunRiseContainer.addArrangedSubview(riseLabel)
        sunSetContainer.addArrangedSubview(setLabel)
        sunRiseContainer.addArrangedSubview(sunrise)
        sunSetContainer.addArrangedSubview(sunset)
        
        sunRiseContainer.addArrangedSubview(sunrise)
        sunSetContainer.addArrangedSubview(sunset)
        
        container.addArrangedSubview(image)
        container.addArrangedSubview(weatherContainer)
        container.addArrangedSubview(temperatureContainer1)
        container.addArrangedSubview(temperatureContainer2)
        container.addArrangedSubview(pressureAndHumidityContainer)
        
        sunStateContainer.addArrangedSubview(sunRiseContainer)
        sunStateContainer.addArrangedSubview(sunSetContainer)
        container.addArrangedSubview(sunStateContainer)
        view.addSubview(container)
        
        
        container.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(view.layoutMarginsGuide)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
