//
//  Comment.swift
//  TikiTestRefactor
//
//  Created by TruongQuangMinh on 6/19/18.
//  Copyright © 2018 TruongQuangMinh. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let name: String
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case name = "rec"
        case comment = "loc"
    }
}

