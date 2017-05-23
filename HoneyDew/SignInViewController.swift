//
//  SignInViewController.swift
//  HoneyDew
//
//  Created by Tennant Shaw on 5/23/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@objc(SignInViewController)

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    // MARK: - Properties
    var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Outlets
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                MeasurementHelper.sendLoginEvent()
                self.performSegue(withIdentifier: Constants.Segues.SignInToGoogle , sender: nil)
            }
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
