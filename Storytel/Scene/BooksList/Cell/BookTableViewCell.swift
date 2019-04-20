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
    
    
    var book: Book? = nil {
        didSet {
            guard let book = book else {
                return
            }
            
            bookTitleLabel.text = book.title
            
            if let authors = book.authors,!authors.isEmpty  {
                let  authorsNames = authors.map { author -> String in
                    return author.name ?? ""
                }
                
                let authorsString = authorsNames.joined(separator: ", ")
                authorsLabel.text = "By \(authorsString)"
            }
            
            
            if let narrators = book.narrators,!narrators.isEmpty {
                
                let  narratorsNames = narrators.map { narrator -> String in
                    return narrator.name ?? ""
                }
                
                let narratorsString = narratorsNames.joined(separator: ", ")
                narratorsLabel.text = "with \(narratorsString)"
            }
            if let urlToImage = book.cover?.url {
                bookCoverImageView.downloaded(from: urlToImage, contentMode: .scaleAspectFill)
            }
            
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        cardView =  UIView()
        cardView.layer.cornerRadius = 5.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 12.0
        cardView.layer.shadowOpacity = 0.7
        cardView.backgroundColor = .red
        addSubview(cardView)
        
        
        
        bookCoverImageView = UIImageView(image: #imageLiteral(resourceName: "default-og-image"))
        cardView.addSubview(bookCoverImageView)
        bookCoverImageView.roundCorners(corners: [.allCorners], radius: 5.0)
        
        bookTitleLabel = UILabel()
        bookTitleLabel.font = UIFont(name: bookTitleLabel.font.fontName, size:15)
        
        bookTitleLabel.numberOfLines = 2
        
        authorsLabel = UILabel()
        authorsLabel.numberOfLines = 2
        
        narratorsLabel = UILabel()
        narratorsLabel.numberOfLines = 2
        
        
        stackView = UIStackView(arrangedSubviews: [bookTitleLabel,authorsLabel,narratorsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        cardView.addSubview(stackView)
        setupConstrain()
        
    }
    
    func setupConstrain() {
        
        cardView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(8)
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        bookCoverImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(bookCoverImageView.snp.width)
            make.height.equalTo(cardView.snp.height).multipliedBy(0.6)
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
