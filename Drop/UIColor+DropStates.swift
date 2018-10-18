//
//  UIColor+DropStates.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct DropState {
        
        static var info = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 0.9)
        static var success = UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 0.9)
        static var warning = UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 0.9)
        static var error = UIColor(red: 192/255.0, green: 57/255.0, blue: 43/255.0, alpha: 0.9)
        static var `default` = UIColor(red: 41/255.0, green: 128/255.0, blue: 185/255.0, alpha: 0.9)
    }
}
