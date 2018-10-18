//
//  DropAppearance.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/17/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

public protocol DropAppearance {
    
    var backgroundColor: UIColor? { get }
    var blurEffect: UIBlurEffect? { get }
    var font: UIFont? { get }
    var textColor: UIColor? { get }
    var textAlignment: NSTextAlignment? { get }
}
