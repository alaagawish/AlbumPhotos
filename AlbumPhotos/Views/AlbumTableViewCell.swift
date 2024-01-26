//
//  AlbumTableViewCell.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addNew(album: Album) {
        self.albumNameLabel.text = album.title
        
        self.albumImageView.kf.setImage(with: URL(string: album.thumbnailUrl), placeholder: UIImage(named: "noImg"))
    }
}
