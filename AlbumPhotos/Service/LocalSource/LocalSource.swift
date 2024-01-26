//
//  LocalSource.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import Foundation
import CoreData
import UIKit

class LocalSource: LocalSourceProtocol {
    var managedContext: NSManagedObjectContext
    init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func getAllAlbums() -> [Album] {
        var localAlbums: [Album] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataConstants.entityName)
        do {
            let albums = try managedContext.fetch(fetchRequest)
            for i in albums {
                let localAlbum = Album(albumId: i.value(forKey: CoreDataConstants.albumId) as! Int,
                                       id: i.value(forKey: CoreDataConstants.id) as! Int,
                                       title: i.value(forKey: CoreDataConstants.title) as! String,
                                       url: i.value(forKey: CoreDataConstants.url) as! String,
                                       thumbnailUrl:  i.value(forKey: CoreDataConstants.image) as! String)
                localAlbums.append(localAlbum)
            }
            print("\nGetting all albums done...\n")
        } catch let error as NSError {
            print("\nerror in fetching all albums: \(error)\n")
        }
        
        return localAlbums
    }
    
    func cacheAll(albums: [Album]) {
        for album in albums {
            let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: managedContext)
            let localAlbum = NSManagedObject(entity: entity!, insertInto: managedContext)
            localAlbum.setValue(album.title, forKey: CoreDataConstants.title)
            localAlbum.setValue(album.albumId, forKey: CoreDataConstants.albumId)
            localAlbum.setValue(album.id, forKey: CoreDataConstants.id)
            localAlbum.setValue(album.url, forKey: CoreDataConstants.url)
            localAlbum.setValue(album.thumbnailUrl, forKey: CoreDataConstants.image)
            
            do {
                try managedContext.save()
                print("\nInserting albums done...\n")
            } catch let error as NSError {
                print("\nerror in caching: \(error)\n")
            }
        }
    }
    
    func deleteAllAlbums() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataConstants.entityName)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            print("All data deleted successfully.")
        } catch {
            print("Error deleting data: \(error)")
        }
        
    }
    
    
}
