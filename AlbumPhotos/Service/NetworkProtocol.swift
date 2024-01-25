//
//  NetworkProtocol.swift
//  AlbumPhotos
//
//  Created by Alaa on 25/01/2024.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    
    func getData(handler: @escaping ([Album]?) -> Void)
}
