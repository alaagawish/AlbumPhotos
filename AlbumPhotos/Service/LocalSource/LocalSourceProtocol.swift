//
//  LocalSourceProtocol.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import Foundation

protocol LocalSourceProtocol {
    func getAllAlbums() -> [Album]
    func cacheAll(albums:[Album])
    func deleteAllAlbums()
}
