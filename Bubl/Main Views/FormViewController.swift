//
//  FormViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 4/30/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class FormViewController: UIViewController {

    @IBOutlet weak var selectedGenderController: UISegmentedControl!
    @IBOutlet weak var lookingForGenderController: UISegmentedControl!
    @IBOutlet weak var selectedActivityController: UISegmentedControl!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSelect.layer.borderColor = #colorLiteral(red: 0.02608692087, green: 0.7744804025, blue: 0.6751230955, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: .personalityTypeName, object: nil)
        let cn : String = Shared.shared.personality ?? "Select your personality type"
        
    }
    
    @objc func handlePopupClosing(notification: Notification) {
        let personalityVC = notification.object as! PopOverViewController
        btnSelect.setTitle(personalityVC.personalityType!, for: .normal)

        
    }
    
    var selectedGender: String = "Male"
    var lookingForGender: String = "Male"
    var selectedActivity: String = "Travel"
    
    @IBAction func selectedGender(_ sender: Any) {
        if selectedGenderController.selectedSegmentIndex == 0 {
           selectedGender = "Male"
        }
        if selectedGenderController.selectedSegmentIndex == 1 {
           selectedGender = "Female"
        }
    }
    
    
    @IBAction func lookingForGender(_ sender: Any) {
        if lookingForGenderController.selectedSegmentIndex == 0 {
            lookingForGender = "Male"
        }
        if lookingForGenderController.selectedSegmentIndex == 1 {
            lookingForGender = "Female"
        }
    }
    
    
    @IBAction func selectedActivity(_ sender: Any) {
        if selectedActivityController.selectedSegmentIndex == 0 {
            selectedActivity = "Travel"
        }
        if selectedActivityController.selectedSegmentIndex == 1 {
            selectedActivity = "Music"
        }
        if selectedActivityController.selectedSegmentIndex == 2 {
            selectedActivity = "Sports"
        }
        if selectedActivityController.selectedSegmentIndex == 3 {
            selectedActivity = "Pets"
        }
        if selectedActivityController.selectedSegmentIndex == 4 {
            selectedActivity = "Movies"
        }
    }
    
    @IBAction func myersBriggsTestBtn(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.16personalities.com/free-personality-test")! as URL, options: [:], completionHandler: nil)
    }
        
    @IBAction func continueToMatch(_ sender: Any) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if btnSelect.titleLabel?.text != "Select your personality type" {
            let user = Auth.auth().currentUser
            
            if let user = user {
                let db = Firestore.firestore()
                db.collection("Users").document(user.uid).setData(["selectedGender" : selectedGender], merge: true)
                db.collection("Users").document(user.uid).setData(["lookingForGender" : lookingForGender], merge: true)
                db.collection("Users").document(user.uid).setData(["selectedActivity" : selectedActivity], merge: true)

                
            }
            
            hud.dismiss(afterDelay: 1.0)

            let alert = UIAlertController(title: "Are you sure?", message: "Do you want to proceed to matches?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes!", style: .destructive, handler: { (action) in
                // Do nothing
                self.performSegue(withIdentifier: "toMatches", sender: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

            self.present(alert, animated: true)
            
        }else {
            hud.dismiss(afterDelay: 1.0)
            
            showAlert(title: "Oops!", message: "You did not complete some of the sections!", buttonTitle: "Dismiss")
        }
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            // Do nothing
        }))

        self.present(alert, animated: true)
    }
    
    
    @IBAction func selectPersonalityType(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popOver = storyBoard.instantiateViewController(withIdentifier: "PopOverViewController")
        self.definesPresentationContext = true
        popOver.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        popOver.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(popOver, animated: true, completion: nil)
        
        
    }
}

