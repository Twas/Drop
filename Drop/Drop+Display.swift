//
//  Drop+Display.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/18/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

// MARK: - Public API -

public extension Drop {
    
    class func down(_ status: String, type: DropType = .default, duration: Double = Defaults.dropDuration, action: DropAction? = nil) {
        show(status, type: type, duration: duration, action: action)
    }
    
    class func down(_ status: String, type: DropAppearance, duration: Double = Defaults.dropDuration, action: DropAction? = nil) {
        show(status, type: type, duration: duration, action: action)
    }
    
    class func upAll() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let drops = window.subviews.compactMap({ $0 as? Drop })
        drops.forEach({ $0.up() })
    }
}
