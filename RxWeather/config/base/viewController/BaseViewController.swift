//
//  BaseViewController.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import UIKit

class BaseViewController: UIViewController {
    var viewModel: ViewModelType
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
