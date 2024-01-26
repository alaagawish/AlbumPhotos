//
//  AlbumsViewController.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import UIKit
import ImageSlideshow

class AlbumsViewController: UIViewController {
    
    @IBOutlet weak var albumsTableView: UITableView!
    var currentAlbums: [Album] = []
    var totalAlbums: [Album] = []
    var albumViewModel: AlbumsViewModel!
    var totalAlbumsCount: Int = 0
    var currentAlbumsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        initValues()
    }
    
    func setUpUI(){
        albumsTableView.register(UINib(nibName: Constants.AlbumTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.AlbumTableViewCellID)
    }
    
    func initValues() {
        albumViewModel = AlbumsViewModel(network: Network(), localSource:  LocalSource())
        
        albumViewModel.passAlbumsToViewController = { [weak self] in
            guard let self = self else {return}
            self.totalAlbumsCount = self.albumViewModel.albums.count
            self.totalAlbums = self.albumViewModel.albums
            if self.totalAlbums.count >= 10 {
                for item in 0..<10 {
                    self.currentAlbums.append(self.albumViewModel.albums[item])
                }
                self.albumViewModel.localSource.cacheAll(albums: self.currentAlbums)
            } else {
                self.currentAlbums = self.totalAlbums
            }
            self.currentAlbumsCount = self.currentAlbums.count
            self.albumsTableView.reloadData()
            
        }
        
        albumViewModel.getAlbums()
    }
    
    func getMoreAlbumsTo(currentLimitNumber: Int) {
        if currentLimitNumber >= totalAlbumsCount {
            return
        } else if currentLimitNumber >= totalAlbumsCount-10 {
            for i in currentLimitNumber..<totalAlbumsCount-10 {
                currentAlbums.append(totalAlbums[i])
            }
        } else {
            for i in currentLimitNumber ..< currentLimitNumber+10 {
                currentAlbums.append(totalAlbums[i])
            }
        }
        cachingAlbums()
        self.currentAlbumsCount += 10
        self.albumsTableView.reloadData()
    }
    
    func cachingAlbums() {
        albumViewModel.localSource.deleteAllAlbums()
        albumViewModel.localSource.cacheAll(albums: currentAlbums)
    }
}


extension AlbumsViewController: ImageSlideshowDelegate {
    
}
