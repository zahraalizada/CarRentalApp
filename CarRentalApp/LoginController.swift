//
//  LoginController.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 18.05.24.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"

    }

    @IBAction func loginTappedButton(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "userRegistered")
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.didHomeController()
        }
    }
    
}
