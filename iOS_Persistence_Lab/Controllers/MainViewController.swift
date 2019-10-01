//
//  MainViewController.swift
//  iOS_Persistence_Lab
//
//  Created by Alexander George Legaspi on 9/30/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var photos = [Photo]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
           collectionView.reloadData()
        }
    }
    
    var searchResults: [Photo] {
        guard let result = searchString else {
            return photos
        }
        guard result != "" else {
            return photos
        }
    
        return photos
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    private func loadData(search: String) {
        PhotoAPIClient.manager.getPhotos(search: search) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print(success)
                    self.photos = success
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? CollectionViewCell {
            let photo = photos[indexPath.item]
            
            ImageHelper.shared.getImage(urlStr: photo.largeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success (let success):
                        cell.imageView.image = success
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.photo = photo
        self.navigationController?.pushViewController(detailVC,animated: true)
    }
    
    
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text ?? ""
        loadData(search: searchString ?? "")
        
    }
}
