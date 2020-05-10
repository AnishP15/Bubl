//
//  PopOverViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 4/30/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class PopOverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

       @IBOutlet weak var Popupview: UIView!
       
       @IBOutlet weak var tableView: UITableView!
           
       var names: [String] = ["ISTJ","ISFJ","INFJ","INTJ","ISTP","INFP","INTP","ESTP","ESFP","ENFP", "ENTP","ESTJ","ESFJ","ENFJ","ENTJ"]
     
       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.dataSource = self
           tableView.delegate = self
        
          // Apply radius to Popupview
           Popupview.layer.cornerRadius = 10
           Popupview.layer.masksToBounds = true
    
       }
       
       
       // Returns count of items in tableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.names.count;
       }
       
       
       // Select item from tableView
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let user = Auth.auth().currentUser
           if let user = user {
               let db = Firestore.firestore()
            db.collection("users").document(user.uid).collection("form").document("personalityType").setData(["personalityType" : names[indexPath.row]])
           }
         
            Shared.shared.personality = names[indexPath.row]
        
           
    
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FormViewController") 
            self.present(newViewController, animated: true, completion: nil)
        
       }
       
       //Assign values for tableView
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
           cell.textLabel?.text = names[indexPath.row]
     
           return cell
       }
       
       // Close PopUp
       @IBAction func closePopup(_ sender: Any) {
           
           dismiss(animated: true, completion: nil)
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
