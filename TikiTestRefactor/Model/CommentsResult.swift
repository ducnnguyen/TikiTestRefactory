//
//  CommentsResult.swift
//  TikiTestRefactor
//
//  Created by TruongQuangMinh on 6/19/18.
//  Copyright © 2018 TruongQuangMinh. All rights reserved.
//

import Foundation

struct CommentsResult {
    let comments: [Comment]?
    let error: Error?
    let currentPage: Int
    let pageCount: Int
    
    var hasMorePages: Bool {
        return currentPage < pageCount
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    
}
