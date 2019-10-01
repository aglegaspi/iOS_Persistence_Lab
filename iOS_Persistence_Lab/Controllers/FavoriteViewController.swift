//
//  FavoriteViewController.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favorites = [Photo]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadFavorites()
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadFavorites() {
        do { favorites = try FavoritePersistenceHelper.manager.getFavorites()
        } catch {
            return
        }
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell {
            let favorite = favorites[indexPath.row]
            
            ImageHelper.shared.getImage(urlStr: favorite.largeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success (let success):
                        cell.favoriteImage.image = success
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.photo = favorite
        self.navigationController?.pushViewController(detailVC,animated: true)
    }
    
    
}
