//
//  PhotoHelper.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    // singelton
    static let manager = PhotoPersistenceHelper()
    
    // save new phoot
    func save(newPhoto: Photo) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    // get new photo
    func getPhotos() throws -> [Photo] {
        return try persistenceHelper.getObjects()
    }
    
    //
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "photos.plist")
    
    private init() {}
}
