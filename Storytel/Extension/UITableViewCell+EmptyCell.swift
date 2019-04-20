//
//  UITableViewCell+EmptyCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/19/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static func getEmptyCell(message: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.isUserInteractionEnabled = false
        cell.textLabel?.text = message
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        cell.textLabel?.textAlignment = .center
        return cell
    }

}
