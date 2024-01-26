//
//  AlbumsViewController+TableView.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import UIKit

extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAlbumsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AlbumTableViewCellID, for: indexPath) as! AlbumTableViewCell
        cell.addNew(album: currentAlbums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == albumsTableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height {
                getMoreAlbumsTo(currentLimitNumber: self.currentAlbumsCount)
            }
        }
    }
    
}
