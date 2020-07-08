//
//  UserResponse.swift
//  Get newsfeed VK
//
//  Created by Nikola on 04/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
