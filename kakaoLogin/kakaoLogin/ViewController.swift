//
//  ViewController.swift
//  kakaoLogin
//
//  Created by 강병우 on 2020/07/28.
//  Copyright © 2020 강병우. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let loginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
      }()

      override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layout()
      }
      
      @objc private func touchUpLoginButton(_ sender: UIButton) {
        guard let session = KOSession.shared() else {
          return
        }
        
        if session.isOpen() {
          session.close()
        }
        
        session.open(completionHandler: { (error) -> Void in
            
            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        UIAlertController.showMessage(error.description)
                    }
                }
            } else { print("로그인완료?")}
        })
      }

      private func layout() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(loginButton)
        
        loginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      }
    }
