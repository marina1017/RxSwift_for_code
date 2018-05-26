//
//  ViewController.swift
//  RxSwift_for_code
//
//  Created by nakagawa on 2018/05/25.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    var number1: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    var number2: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    var number3: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var label: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.number1)
        self.number1.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.number2)
        self.number2.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.number1.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.number3)
        self.number3.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.number2.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.label)
        self.label.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.number3.snp.bottom)
            make.centerX.equalTo(self.view)
        }

    Observable.combineLatest(number1.rx.text.orEmpty,number2.rx.text.orEmpty,number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description}
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

