//
//  AlbumsViewModel.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import Foundation

class AlbumsViewModel {
    
    var network: NetworkProtocol!
    var localSource: LocalSourceProtocol!
    var passAlbumsToViewController: (()->()) = {}
    var albums: [Album] = [] {
        didSet {
            passAlbumsToViewController()
        }
    }
    
    init(network: NetworkProtocol, localSource: LocalSourceProtocol) {
        self.network = network
        self.localSource = localSource
    }
    
    func getAlbums() {
        if InternetConnection.sharedInstance.isConnectedToInternet() {
            
            network.getData { albums in
                self.albums = albums ?? []
            }
            localSource.deleteAllAlbums()
            
        } else {
            self.albums = localSource.getAllAlbums()
        }
    }
}
