//
//  UIView+RoundCorners.swift
//  Storytel
//
//  Created by BinaryBoy on 4/19/19.
//  Copyright © 2018 BinaryBoy. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}
