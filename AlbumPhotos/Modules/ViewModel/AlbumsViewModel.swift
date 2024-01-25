//
//  AlbumsViewModel.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import Foundation

class AlbumsViewModel {
    
    var network: NetworkProtocol!
    var passAlbumsToViewController: (()->()) = {}
    var albums: [Album] = [] {
        didSet {
            passAlbumsToViewController()
        }
    }
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getAlbums() {
        network.getData { albums in
            self.albums = albums ?? []
        }
    }
}
