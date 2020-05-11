//
//  UITapGestureRecognizer.swift
//  Bubl
//
//  Created by Anish Palvai on 5/11/20.
//  Copyright © 2020 Anish Palvai. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {

    func didTapAttributedTextInTextView(textView: UITextView, inRange targetRange: NSRange) -> Bool {
        let layoutManager = textView.layoutManager
        let locationOfTouch = self.location(in: textView)
        let index = layoutManager.characterIndex(for: locationOfTouch, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(index, targetRange)
    }
}
