//
//  DropType.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

public enum DropType: DropAppearance {
    
    case `default`, info, success, warning, error, color(UIColor), blur(UIBlurEffect.Style)
    
    public var backgroundColor: UIColor? {
        switch self {
        case .info: return UIColor.DropState.info
        case .success: return UIColor.DropState.success
        case .warning: return UIColor.DropState.warning
        case .error: return UIColor.DropState.error
        case .color(let color): return color
        case .blur: return nil
        default: return UIColor.DropState.default
        }
    }
    
    public var font: UIFont? {
        switch self {
        default: return UIFont.systemFont(ofSize: 17.0)
        }
    }
    
    public var textColor: UIColor? {
        switch self {
        default: return .white
        }
    }
    
    public var blurEffect: UIBlurEffect? {
        switch self {
        case .blur(let style): return UIBlurEffect(style: style)
        default: return nil
        }
    }
    
    public var textAlignment: NSTextAlignment? {
        switch self {
        default:
            return .center
        }
    }
}
