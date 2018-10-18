//
//  CustomDrop.swift
//  Drop Demo
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

enum CustomDrop: DropAppearance {
    case blackGreen
    
    var backgroundColor: UIColor? {
        switch self {
        case .blackGreen:
            return .black
        }
    }
    
    var font: UIFont? {
        switch self {
        case .blackGreen:
            return UIFont(name: "HelveticaNeue-Light", size: 24)
        }
    }
    
    var textColor: UIColor? {
        switch self {
        case .blackGreen:
            return .green
        }
    }
    
    var textAlignment: NSTextAlignment? {
        switch self {
        case .blackGreen:
            return .right
        }
    }
    
    var blurEffect: UIBlurEffect? {
        switch self {
        case .blackGreen:
            return nil
        }
    }
}
