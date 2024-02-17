//
//  BookmarkTableViewCell.swift
//  HWlesson23
//
//  Created by Карина Дьячина on 16.02.24.
//

import UIKit

protocol StringDelegate: AnyObject {
    func recieveString(text: String)
}

class BookmarkTableViewCell: UITableViewCell {
    
    lazy var bookmarkLabel: UILabel = {
        bookmarkLabel = UILabel()
        bookmarkLabel.frame =  CGRect(x: 20, y: 20, width: 350, height: 30)
        return bookmarkLabel
    }()
    
    lazy var bookmarkURLLabel: UILabel = {
        bookmarkURLLabel = UILabel()
        bookmarkURLLabel.frame =  CGRect(x: 20, y: 60, width: 350, height: 30)
        return bookmarkURLLabel
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBookmarkLabels()
    }
    
    func setupBookmarkLabels() {
        addSubview(bookmarkLabel)
        addSubview(bookmarkURLLabel)
    }
    
    func configure(bookmark: Bookmark) {
        bookmarkLabel.text = "\(bookmark.name)"
        bookmarkURLLabel.text = "\(bookmark.url)"
        
    }
    
}

extension BookmarkTableViewCell: StringDelegate {
    
    func recieveString(text: String) {
        self.bookmarkURLLabel.text = text
        print("Get message: \(text)")
    }
}
