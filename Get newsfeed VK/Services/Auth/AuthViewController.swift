//
//  ViewController.swift
//  Get newsfeed VK
//
//  Created by Nikola on 29/06/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 15)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
        view.addSubview(loginButton)
        loginBtnConstraints()
       
    }
    
}

extension AuthViewController {
    
    func loginBtnConstraints() {
        
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 313),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func loginButtonAction() {
        print("button tapped")
        
        authService.wakeUpSession()
    }
}
