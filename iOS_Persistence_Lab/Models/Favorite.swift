//
//  Favorite.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct Favorite: Codable {
    
    let largeImageURL: String?
    let likes: Int?
    let id: Int?
    let views: Int?
    let pageURL: String?
    let webformatURL: String?
    let tags: String?
    let favorites: Int?
    let userImageURL: String?
    let previewURL: String?
}
