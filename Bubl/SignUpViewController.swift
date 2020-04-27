//
//  SignUpViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 4/26/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
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
                Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
                    if error == nil {
                        self.performSegue(withIdentifier: "signUptoMain", sender: nil)
                    }
                    else {
                        self.warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        self.warningLabel.text = "Use a valid email with a password of atleast 6 characters."
                    }
                }
            }
        }
        else {
            warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            warningLabel.text = "Use a valid email with a password of atleast 6 characters."
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
