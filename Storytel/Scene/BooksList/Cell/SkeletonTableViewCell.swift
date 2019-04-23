//
//  SkeltonTableViewCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/23/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import SkeletonView

class SkeltonTableViewCell: UITableViewCell, CellReusable {
    
    
    var bookCoverImageView: UIImageView!
    var bookTitleLabel: UILabel!
    
    private struct CoverView {

        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupBookCoverImageView()

        setupLabel()
        
        setupSkeleton()
    }
    
    private func setupSkeleton() {
        
        isSkeletonable = true

        bookCoverImageView.isSkeletonable = true
        bookTitleLabel.isSkeletonable = true
        
        bookTitleLabel.lastLineFillPercent = 50
        bookTitleLabel.linesCornerRadius = 5
        
        SkeletonAppearance.default.multilineHeight = 10
        SkeletonAppearance.default.tintColor = .flatOrange

        let gradient = SkeletonGradient(baseColor: UIColor.carrot)
        
        setupConstraints()
        layoutIfNeeded()
        
        bookTitleLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil)
        bookCoverImageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: nil)
        
    }
    
    private  func setupBookCoverImageView() {
        
        bookCoverImageView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        addSubview(bookCoverImageView)
        bookCoverImageView.roundCorners(corners: [.allCorners], radius: 5.0)
    }
    
    private func setupLabel() {
        
        bookTitleLabel = UILabel()
        bookTitleLabel.font = UIFont(name: bookTitleLabel.font.fontName, size:15)
        bookTitleLabel.text = ""
        bookTitleLabel.numberOfLines = 5
        addSubview(bookTitleLabel)
        
    }
    
    
    private func setupConstraints() {
        
        bookCoverImageView.snp.makeConstraints { (make) -> Void in
            let width = CoverView.width
            let height = CoverView.height
            
            make.width.equalTo(width)
            make.height.equalTo(height)
            
            make.centerY.equalTo(self)
            make.right.equalTo(bookTitleLabel.snp.left).offset(-20)
            make.left.equalTo(self).offset(8)
            
        }
        
        bookTitleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.right.equalTo(self).offset(8)
            make.centerY.equalTo(self)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
