//
//  UITableView+LastCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/19/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit

extension UITableView {

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}
