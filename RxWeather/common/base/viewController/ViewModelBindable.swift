//
//  ViewModel.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import UIKit
protocol ViewModelBindable {
    associatedtype ViewModel
    var viewModel: ViewModel! {get set}
    func bindViewModel()
    func setUI()
}

extension ViewModelBindable where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModel){
        self.viewModel = viewModel
        loadViewIfNeeded()
        setUI()
        bindViewModel()
    }
}
