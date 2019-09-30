//
//  PhotoAPIClient.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct PhotoAPIClient {
    
    static let manager = PhotoAPIClient()
    
    func getPhotos(search: String, completionHandler: @escaping (Result<[Photo], AppError>) -> Void) {
        
        let api_key = Secrets.api_key
        
        let urlString = "https://pixabay.com/api/?key=\(api_key)&q=\(search.lowercased().replacingOccurrences(of: " ", with: "+"))"
        print(urlString)
        guard let url = URL(string: urlString) else {
            fatalError("bad URL")
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
                return
            case let .success(data):
                do {
                    let Photos = try Photo.getPhotos(from: data)
                    completionHandler(.success(Photos))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    private init() {}
}
