//
//  ViewController.swift
//  AppleSignInSample
//
//  Created by Sachin Siwal on 13/01/20.
//  Copyright © 2020 Sachin Siwal. All rights reserved.
//


import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            AppleSignIn.shared.addSignInButton(onView: self.view, frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), completion: { appleUser, error in
                if error == nil {
                    if appleUser != nil {
                        print(appleUser?.identifier ?? "", appleUser?.fName ?? "")
                    }
                } else {
                    print("\(String(describing: error)) Please check your Apple ID in phone settings. You must be sign in to iCloud account and 2 factor authentication must be turned on.")
                }
                
            })
            
            
        } else {
            // Fallback on earlier versions
        }
    }
}
    
