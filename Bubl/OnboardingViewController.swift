//
//  OnboardingViewController.swift
//  Bubl
//
//  Created by Anish Palvai on 5/9/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var createAcct: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAcct.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

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
