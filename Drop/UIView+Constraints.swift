//
//  UIView+Constraints.swift
//  Drop
//
//  Created by Evgeniy Leychenko on 10/18/18.
//  Copyright © 2018 TAS. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintInsideSuperview(topOffset: CGFloat = 0) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: topOffset).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func pinToSuperviewBottomUsingSideMargins(bottomOffset: CGFloat = 0) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomOffset).isActive = true
    }
}
