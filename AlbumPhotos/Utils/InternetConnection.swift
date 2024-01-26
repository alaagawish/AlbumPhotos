//
//  InternetConnection.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import Foundation
import Reachability

class InternetConnection {
    
    static let sharedInstance = InternetConnection()
    
    var reachability: Reachability? {
        do {
            return try Reachability()
        } catch {
            print("Unable to create Reachability")
            return nil
        }
    }
    
    func isConnectedToInternet() -> Bool {
        print(reachability?.isReachable)
        return reachability?.isReachable ?? false
    }
    
    private init() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
