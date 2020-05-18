//
//  WZAssestCollectionViewCell.swift
//  imagePickerWz
//
//  Created by Adeel on 19/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import UIKit
import Photos

class WZAssestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var selectedIconImageView : UIImageView!
    @IBOutlet weak var selectedAlphaView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func populateCellsData (_ image : UIImage?)
    {
        if let assestImage = image
        {
            imageView.image = assestImage
        }
        else
        {
            imageView.image = CustomMethods.placeholderImageWithSize(imageView.bounds.size)
        }
    }
    
    func populateCellDataWithAssets(_ assest : PHAsset?)
    {
        if let imgAsset = assest
        {
            let image  = CustomMethods.getAssetThumbnail(asset: imgAsset)
            
            imageView.image = image
        }
        else
        {
            imageView.image = CustomMethods.placeholderImageWithSize(imageView.bounds.size)
        }
        
        
    }
}
