//
//  ViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 4/25/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func continueTapped(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
                    if error == nil{
                        self.performSegue(withIdentifier: "loginToMain", sender: nil)
                    }
                    else {
                        self.warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        self.warningLabel.text = "Unable to login."
                    }
                }
            }
        }
        
        else {
            warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            warningLabel.text = "Unable to login."
        }
        
    }
    
}

