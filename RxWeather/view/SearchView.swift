//
//  SearchView.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import UIKit

final class SearchView: BaseViewController, ViewModelBindable{
    let input: CustomTextField = CustomTextField(frame: .zero)
    let imgView: UIImageView = UIImageView(image: UIImage(named: "logo"))
    
    var viewModel: SearchViewModel!
    func bindViewModel() {
    }
    
    func setUI() {
        input.delegate = self
        view.addSubview(input)
        view.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        let layerWidth = view.bounds.width
        
        imgView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
//            make.trailing.leading.equalTo(view).offset(30)
            make.centerY.equalTo(view).multipliedBy(0.5)
            make.width.equalTo(layerWidth / 2)
            make.height.equalTo(layerWidth / 2)
        }
        input.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(1.25)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.greaterThanOrEqualTo(300)
        }
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
    }
}
extension SearchView: CustomTextFieldDelegate {
    func tab(city: City) {
        
        present(UIAlertController(title: "?", message: city.name, preferredStyle: .alert), animated: true)
    }
    
    
}

