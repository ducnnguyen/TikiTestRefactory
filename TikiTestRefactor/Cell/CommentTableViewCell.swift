//
//  CommentTableViewCell.swift
//  TikiTestRefactor
//
//  Created by TruongQuangMinh on 6/19/18.
//  Copyright © 2018 TruongQuangMinh. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let ReuseIdentifier = String(describing: CommentTableViewCell.self)
    static let NibName = String(describing: CommentTableViewCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func load(comment: Comment) {
        nameLabel.text = comment.name
        commentLabel.text = comment.comment
    }
    
}
