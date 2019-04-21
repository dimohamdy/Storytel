//
//  UIImageView+DownloadImage.swift
//  Storytel
//
//  Created by BinaryBoy on 4/19/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "default-og-image"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
