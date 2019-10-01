//
//  DetailViewController.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo: Photo!
    //var favorite = Favorite()
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var likesView: UILabel!
    @IBOutlet weak var favoritesView: UILabel!
    @IBOutlet weak var tagsView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageHelper.shared.getImage(urlStr: photo.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success (let success):
                    self.photoView.image = success
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        likesView.text = "Likes: \(photo.likes)"
        favoritesView.text = "Favorited: \(photo.favorites)"
        tagsView.text = "Tags: \(photo.tags)"
    }

    @IBAction func buttonPressed(_ sender: Any) {
        do {
            try FavoritePersistenceHelper.manager.save(newFavorite: photo)
            print("successfully added to favorites")
        } catch {
            return
        }
        
    }
}
