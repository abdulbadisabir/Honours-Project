//
//  NoCursorTextField.swift
//  LetsGo
//
//  Created by abdulbadi sabir on 2017-11-18.
//  Copyright © 2017 abdulbadi sabir. All rights reserved.
//

import UIKit

class NoCursorTextField: UITextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
