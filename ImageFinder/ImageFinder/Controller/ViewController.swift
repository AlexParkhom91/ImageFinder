//
//  ViewController.swift
//  ImageFinder
//
//  Created by Александр Пархамович on 16.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - SearchBar + CollectionView
    
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    // MARK: - Varibles
    
    var images: [ImagesSeachResult] = []
    
    // MARK: - UI Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupCollectionView()
        setupSearchBar()
    }
    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageViewCell.nib(),
                                     forCellWithReuseIdentifier: "ImageViewCell")
        let layout = UICollectionViewFlowLayout()
        let itemSize = (view.frame.width - 15) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        imageCollectionView.collectionViewLayout = layout
    }
    // MARK: - Get images from Api
    func fetchPhotos(for query: String) {
        APIManager.shared.fetchPhotos(for: query) { [weak self] result in
            switch result {
            case .success(let images):
                DispatchQueue.main.async {
                    self?.images = images
                    self?.imageCollectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

