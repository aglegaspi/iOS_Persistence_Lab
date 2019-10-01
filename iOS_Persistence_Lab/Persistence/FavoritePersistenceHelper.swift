//
//  FavoritePersistenceHelper.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct FavoritePersistenceHelper {
    // singelton
    static let manager = FavoritePersistenceHelper()
    
    // save new phoot
    func save(newFavorite: Photo) throws {
        try persistenceHelper.save(newElement: newFavorite)
    }
    
    // get new photo
    func getFavorites() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
    //
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "favorites.plist")
    
    private init() {}
}
