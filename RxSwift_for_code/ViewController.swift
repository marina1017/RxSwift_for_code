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

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    var userName: UILabel = {
        let label = UILabel()
        label.text = "userName"
        return label
    }()

    var userNameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var userNameValidLable: UILabel = {
        let label = UILabel()
        label.text = "userName"
        return label
    }()

    var password: UILabel = {
        let label = UILabel()
        label.text = "password"
        return label
    }()

    var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()

    var passwordValidLable: UILabel = {
        let label = UILabel()
        label.text = "password"
        return label
    }()

    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("テスト", for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeUILayout()
        userNameValidLable.text = "ユーザー名は\(minimalUsernameLength) 文字以上"
        passwordValidLable.text = "パスワードは\(minimalPasswordLength) 文字以上"

        let userNameValid = userNameField.rx.text.orEmpty
            .map{$0.count >= minimalUsernameLength}
            //このマップがない場合は、バインディングごとに1回実行され、rxはデフォルトではステートレスです
            .share(replay: 1)

        let passwordValid = passwordField.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength}
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(userNameValid, passwordValid){ $0 && $1 }
            .share(replay: 1)

        userNameValid.bind(to: passwordField.rx.isEnabled).disposed(by:disposeBag)

        userNameValid.bind(to: userNameValidLable.rx.isHidden).disposed(by:disposeBag)

        passwordValid.bind(to: passwordValidLable.rx.isHidden).disposed(by: disposeBag)
        
        everythingValid.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        
        button.rx.tap.subscribe(onNext: {[weak self] _ in self?.showAlert()})
        
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }

    func initializeUILayout() {
        self.view.addSubview(self.userName)
        self.userName.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.userNameField)
        self.userNameField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.userName.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.userNameValidLable)
        self.userNameValidLable.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.userNameField.snp.bottom)
            make.centerX.equalTo(self.view)
        }

        self.view.addSubview(self.password)
        self.password.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.userNameValidLable.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.passwordField)
        self.passwordField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.password.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(self.passwordValidLable)
        self.passwordValidLable.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.passwordField.snp.bottom)
            make.centerX.equalTo(self.view)
        }

        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(self.passwordValidLable.snp.bottom)
            make.centerX.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

