//
//  AlbumTableViewCell.swift
//  AlbumPhotos
//
//  Created by Alaa on 26/01/2024.
//

import UIKit
import Kingfisher
import ImageSlideshow
import ImageSlideshowKingfisher

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageSlide: ImageSlideshow!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addNew(album: Album, viewController: UIViewController) {
        self.albumNameLabel.text = album.title
        self.viewController = viewController
        startSlider(image: album.thumbnailUrl)
    }
    
    func startSlider(image: String) {
        imageSlide.slideshowInterval = 5.0
        imageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        
        imageSlide.contentScaleMode = .scaleAspectFill
        imageSlide.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .bottom)
        
        imageSlide.activityIndicator = DefaultActivityIndicator()
        imageSlide.delegate = viewController as? any ImageSlideshowDelegate
        let  images: [KingfisherSource] = [KingfisherSource(urlString:image)!]
        
        imageSlide.setImageInputs(images)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSlide.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        let fullScreenController = imageSlide.presentFullScreenController(from: viewController)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
}
