//
//  SearchView.swift
//  RxWeather
//
//  Created by Sang Hyeon kim on 2023/03/05.
//

import UIKit
import RxSwift

final class SearchView: BaseViewController, ViewModelBindable{
    let input: CustomTextField = CustomTextField(frame: .zero)
    let imgView: UIImageView = UIImageView(image: UIImage(named: "logo"))
    
    var viewModel: SearchViewModel!
    func bindViewModel() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Observable.just("").bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
    }
    func setUI() {
        navigationItem.title = viewModel.title
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
        
        let keyboardShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map{ $0.cgRectValue.height }
        let keyboardHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map{ noti -> CGFloat in 0 }
        let originY = view.frame.origin.y
        Observable.merge(keyboardShow, keyboardHide)
            .share()
            .withUnretained(self)
            .subscribe(onNext: { this, height in
                this.view.frame.origin.y = originY - ( height != 0 ? 250 : 0)
            }).disposed(by: rx.disposeBag)
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
    }
}
extension SearchView: CustomTextFieldDelegate {
    func tab(city: City) {
        var detailView = DetailView()
        let detailViewModel = DetailViewModel(title: city.name, service: self.viewModel.service, log: self.viewModel.log, city:  city)
        detailView.bind(viewModel: detailViewModel)
        Observable.just("검색").bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
        self.navigationController?.pushViewController(detailView, animated: true)
        
        
//        viewModel.service.get(city: city)
//            .subscribe{ [unowned self ] data in
//
//                detailViewModel.setData(response: data)
//                detailView.bind(viewModel: detailViewModel)
////                detailView.modalPresentationStyle = .fullScreen
//
//        }.disposed(by: rx.disposeBag)
    }
}

