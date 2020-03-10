//
//  WZAlbumCollectionViewCell.swift
//  imagePickerWz
//
//  Created by Adeel on 19/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import UIKit
import Photos

class WZAlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageview2            : UIImageView!
    @IBOutlet var albumsTitle           : UILabel!
    @IBOutlet var numberOfPhotos        : UILabel!
    @IBOutlet var mainBackgroundView    : UIView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setBorderWidth (_ borderWidth : CGFloat)
    {
//        imageview2.layer.borderColor  = UIColor.white.cgColor
//        imageview2.layer.borderWidth  = borderWidth
        imageview2.layer.cornerRadius = 10
       
    }
    
    
    func setAssestInCollectionview (_ assest :  PHAssetCollection, _ indexPath : IndexPath, _ selectedMediaType : Int?)
        {
            self.tag = indexPath.item
            
            let fetchOptions = PHFetchOptions()

            if (selectedMediaType != nil)
            {
                fetchOptions.predicate = NSPredicate(format: "mediaType == \(selectedMediaType ?? 1)")
            }
            else
            {
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
            }
            
            let fetchAssetsResult = PHAsset.fetchAssets(in: assest, options: fetchOptions)
            
            
//            if let imageAlbum = image
//            {
//                imageview2.image = imageAlbum
//            }
//            else
//            {
//                let placeHoderImage = CustomMethods.placeholderImageWithSize(imageview1.frame.size)
//                imageview2.image = placeHoderImage
//            }
            if (fetchAssetsResult.count == 0)
            {
                let placeHoderImage = CustomMethods.placeholderImageWithSize(imageview2.frame.size)
                imageview2.image = placeHoderImage
            }
            else
            {
                let imageManager        = PHImageManager()
                imageManager.requestImage(for: fetchAssetsResult[fetchAssetsResult.count - 1], targetSize: CGSize(width: 100,height: 100), contentMode: .aspectFill, options: nil) { (image, dict) in
                    
                    self.imageview2.image = image
                }
            }

            
            if fetchAssetsResult.count == 0
            {
               
                
                let placeHoderImage = CustomMethods.placeholderImageWithSize(imageview2.frame.size)
               
                imageview2.image = placeHoderImage
                
            }
            
            albumsTitle.text = assest.localizedTitle
            numberOfPhotos.text = "\(fetchAssetsResult.count)"
        }
}
