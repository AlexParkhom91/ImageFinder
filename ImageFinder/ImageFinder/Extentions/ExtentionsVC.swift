//
//  ExtentionsVC.swift
//  ImageFinder
//
//  Created by Александр Пархамович on 16.02.23.
//

import Foundation
import UIKit
// MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = images[indexPath.row].thumbnail
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageViewCell",
            for: indexPath
        ) as? ImageViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageURLString)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailVC.currentImage = images[indexPath.row]
        detailVC.position = indexPath.row
        detailVC.imagesResults = images
        navigationController?.show(detailVC, sender: self)
    }
}

// MARK: Cell parametres
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (view.frame.width ) / 2.5
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: Search bar
extension ViewController: UISearchBarDelegate {
    func setupSearchBar() {
        imageSearchBar.delegate = self
        imageSearchBar.searchTextField.textColor = .black
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            images = []
            imageCollectionView?.reloadData()
            fetchPhotos(for: text)
        }
    }
}
