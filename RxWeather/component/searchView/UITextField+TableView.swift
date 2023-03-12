//
//  UITextField+TableView.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx

protocol CustomTextFieldDelegate {
    func tab(city: City)
}
class CustomTextField: UIView {
    private var textInput :UITextField
    private var recommendTable: UITableView
    private var citySource: [City]?
    public var delegate: CustomTextFieldDelegate?
    
    private lazy var cityPublisher =  PublishSubject<[City]>()
    
    override init(frame: CGRect) {
        textInput = UITextField(frame: .zero)
        recommendTable = UITableView(frame: .zero)
        super.init(frame: frame)
        cityPublisher.onNext([])
        readyJSON()
        setUpUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func readyJSON() {
        do {
            guard let path = Bundle.main.url(forResource: "cityList", withExtension: "json") else {fatalError()}
            citySource = try  JSONDecoder().decode([City].self, from: Data(contentsOf: path))
        } catch {
           citySource = []
        }
    }
    private func setUpUI(){
        cityPublisher
            .map{ $0.count == 0 ? true : false }
            .bind(to: recommendTable.rx.isHidden)
            .disposed(by: rx.disposeBag)
        
        recommendTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(textInput)
        self.addSubview(recommendTable)
        
        textInput.borderStyle = .roundedRect
        textInput.layer.borderWidth = CGFloat(0.5)
        textInput.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.1)
            make.leading.trailing.equalTo(self)
        }
        recommendTable.snp.makeConstraints { make in
            make.top.equalTo(textInput.snp.bottom).offset(5)
            make.bottom.equalTo(self)
            make.leading.trailing.equalTo(self)
        }
    }
    private func bind() {
        textInput.rx.text
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .map{ this, text in
                guard let source = this.citySource else { return [] }
                return source.filter{ $0.name.contains(text!) }
            }
            .subscribe{
                self.cityPublisher.onNext($0)
            }
            .disposed(by: rx.disposeBag)
        cityPublisher
        .bind(to: recommendTable.rx.items(cellIdentifier: "cell")) { row, city, cell in
            cell.textLabel?.text = city.name
            cell.layer.borderWidth = CGFloat(0.5)
            cell.layer.backgroundColor = UIColor.systemGray.cgColor
        }.disposed(by: rx.disposeBag)
        Observable.zip(recommendTable.rx.modelSelected(City.self), recommendTable.rx.itemSelected)
            .withUnretained(self)
            .do(onNext: { this, data in
                this.recommendTable.deselectRow(at: data.1, animated: true)
            })
            .map{ $0.1 }
            .withUnretained(self)
            .subscribe{ this, data in
                print(data.0)
                this.tab(city: data.0)
            }.disposed(by: rx.disposeBag)
                
    }
    private func tab(city: City) {
        delegate?.tab(city: city);
    }
}
