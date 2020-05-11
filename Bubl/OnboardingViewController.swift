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
    @IBOutlet weak var textView: UITextView!
    
    var tap: UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAcct.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap!.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap!)

        // Do any additional setup after loading the view.
    }
    
    @objc func tapped() {
        guard let text = textView.attributedText?.string else {
                return
        }
        let tos = "Terms of Service"
        if let range = text.range(of: tos),
            tap!.didTapAttributedTextInTextView(textView: textView, inRange: NSRange(range, in: text)) {
            performSegue(withIdentifier: "termsOfServiceViewController", sender: nil)
        }
        let privacyPolicy = "Privacy Policy"
        if let range = text.range(of: privacyPolicy),
            tap!.didTapAttributedTextInTextView(textView: textView, inRange: NSRange(range, in: text)) {
            performSegue(withIdentifier: "privacyPolicyViewController", sender: nil)
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
