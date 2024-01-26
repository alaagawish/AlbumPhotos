//
//  Network.swift
//  AlbumPhotos
//
//  Created by Alaa on 25/01/2024.
//

import Foundation
import Alamofire

class Network: NetworkProtocol {
    func getData(handler: @escaping ([Album]?) -> Void) {
        AF.request(Constants.BaseURL).responseDecodable(of: [Album].self) { response in
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    
}
