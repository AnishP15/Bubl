//
//  privacyPolicyViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 5/16/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit

class privacyPolicyViewController: UIViewController {

    @IBOutlet weak var privacyPolicyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        privacyPolicyTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        privacyPolicyTextView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Do any additional setup after loading the view.
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
