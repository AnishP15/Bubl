//
//  SignUpViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 4/26/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var instagramHandleTextField: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        instagramHandleTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueTapped(_ sender: Any) {
        if let instaHandle = instagramHandleTextField.text {
            if let email = emailTextField.text {
                if let password = passwordTextField.text {
                    Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
                        if error == nil {
                            let user = Auth.auth().currentUser
                            if let user = user {
                                let db = Firestore.firestore()
                                db.collection("Users").document(user.uid).setData(["igHandle" : instaHandle], merge: true)
                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormViewController")
                                
                                self.present(viewController, animated: true, completion: nil)

                            }
                        }
                        else {
                            self.warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                            self.warningLabel.text = "Unable to Sign Up."
                        }
                    }
                }
            }
        }
        else {
            warningLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            warningLabel.text = "Unable to Sign Up."
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
