//
//  LoadingTableViewCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import SnapKit

class LoadingTableViewCell: UITableViewCell, CellReusable {

    private var activityIndicator: UIActivityIndicatorView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        addSubview(activityIndicator)

        setupConstraints()
    }

    private func setupConstraints() {
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
