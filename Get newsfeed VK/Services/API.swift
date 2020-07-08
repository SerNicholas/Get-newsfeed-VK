//
//  API.swift
//  Get newsfeed VK
//
//  Created by Nikola on 04/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import Foundation

struct API: Codable {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.120"
    
    static let newsFeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
