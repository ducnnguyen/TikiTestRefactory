//
//  ServiceResponse.swift
//  TikiTestRefactor
//
//  Created by TruongQuangMinh on 6/19/18.
//  Copyright © 2018 TruongQuangMinh. All rights reserved.
//

import Foundation

struct ServiceResponse: Codable {
    let recordings: [Comment]
    let page: Int
    let numPages: Int
}
