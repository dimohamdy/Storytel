//
//  HeaderTableViewCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import SnapKit

class HeaderTableViewCell: UITableViewCell, CellReusable {

    private var queryLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        queryLabel = UILabel()
        queryLabel.numberOfLines = 1
        addSubview(queryLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        queryLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
    }

    func config(header: String) {
        queryLabel.text = header
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
