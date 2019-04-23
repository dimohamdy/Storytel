//
//  BookCell.swift
//  Storytel
//
//  Created by BinaryBoy on 4/18/19.
//  Copyright © 2019 BinaryBoy. All rights reserved.
//

import UIKit
import SnapKit

class BookTableViewCell: UITableViewCell, CellReusable {
    
    var bookCoverImageView: UIImageView!
    var bookTitleLabel: UILabel!
    var authorsLabel: UILabel!
    var narratorsLabel: UILabel!
    var cardView: UIView!
    var stackView: UIStackView!
    
    struct CardView {
        
        static let cornerRadius: CGFloat = 5.0
        static let shadowColor = UIColor.gray.cgColor
        static let shadowRadius: CGFloat = 12.0
        static let shadowOpacity: Float = 0.7
    }
    
    let numberOfLinesForLabels = 2
    
    var book: Book? = nil {
        didSet {
            guard let book = book else {
                return
            }
            
            bookTitleLabel.text = book.title
            
            if let authors = book.authors,!authors.isEmpty  {
                
                let  authorsString = authors.map { author -> String in
                    return author.name ?? ""
                }.joined(separator: ", ")
                
                authorsLabel.text = "By \(authorsString)"
            }
            
            
            if let narrators = book.narrators,!narrators.isEmpty {
                
                let  narratorsString = narrators.map { narrator -> String in
                    return narrator.name ?? ""
                }.joined(separator: ", ")
                
                narratorsLabel.text = "with \(narratorsString)"
            }
            
            if let pathToImage = book.cover?.url {
                bookCoverImageView.download(from: pathToImage, contentMode: .scaleAspectFill)
            }
            
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupCardView()
        
        setupBookCoverImageView()
        
        setupLabels()
        
        setupStackView()
        
        setupConstraints()
        
    }
    
    func setupStackView() {
        
        stackView = UIStackView(arrangedSubviews: [bookTitleLabel,authorsLabel,narratorsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        cardView.addSubview(stackView)
    }
    
    func setupBookCoverImageView() {
        
        bookCoverImageView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        cardView.addSubview(bookCoverImageView)
        bookCoverImageView.roundCorners(corners: [.allCorners], radius: 5.0)
    }
    
    func setupCardView() {
        
        cardView =  UIView()
        cardView.layer.cornerRadius = CardView.cornerRadius
        cardView.layer.shadowColor = CardView.shadowColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = CardView.shadowRadius
        cardView.layer.shadowOpacity = CardView.shadowOpacity
        cardView.backgroundColor = .carrot
        addSubview(cardView)
    }
    
    func setupLabels() {
        
        bookTitleLabel = UILabel()
        bookTitleLabel.font = UIFont(name: bookTitleLabel.font.fontName, size:15)
        
        bookTitleLabel.numberOfLines = 1
        
        authorsLabel = UILabel()
        authorsLabel.numberOfLines = numberOfLinesForLabels
        
        narratorsLabel = UILabel()
        narratorsLabel.numberOfLines = numberOfLinesForLabels
    }
    
    func setupConstraints() {
        
        cardView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(8)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        bookCoverImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(cardView.snp.height).multipliedBy(0.8)
            make.height.equalTo(bookCoverImageView.snp.width)
            make.centerY.equalTo(cardView)
            make.left.equalTo(cardView).offset(8)
        }
        
        stackView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(bookCoverImageView.snp.right).offset(8)
            make.right.equalTo(cardView).offset(8)
            make.centerY.equalTo(cardView)
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookCoverImageView.image = nil
        bookTitleLabel.text = ""
        authorsLabel.text = ""
        narratorsLabel.text = ""
    }
    
}
