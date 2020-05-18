
//
//  CustomMethods.swift
//  WzPicker
//
//  Created by Adeel on 12/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import Foundation
import UIKit
import Photos

public enum SelectedMediaType : Int
{
    case images = 1
    case videos = 2
}

public enum SelectionType : String
{
    case singleImageSelection = "1"
    case multiImageSelection = "2"
}

class CustomMethods: NSObject {
    
    static func standardSizeOfcollectionviewCell(_ presentedViewWith : CGFloat) -> CGSize
    {
        /// NH: 40 margin is due to because , we left space from left and right on each cell ,
        let screenWidthWithSidesMargen  = presentedViewWith - 40.5
        let widthOfView                 = screenWidthWithSidesMargen / 3
        
        let heighMargin                 = widthOfView * 0.1607
        return CGSize(width: widthOfView, height: widthOfView + heighMargin)
    }
    
    static func getSizeOfcollectionviewCell(_ presentedViewWith : CGFloat, sectionInsets: UIEdgeInsets) -> CGSize
    {
        var imagesPerRow = presentedViewWith / 3
        if (imagesPerRow > 125) {
            imagesPerRow = 4
        }
        
        let paddingSpace = sectionInsets.left * (imagesPerRow + 1)
        let availableWidth = presentedViewWith - paddingSpace
        let widthPerItem = availableWidth / imagesPerRow

        return CGSize(width: widthPerItem-2, height: widthPerItem-2)
    }
    
    static func getAssetThumbnail(asset: PHAsset) -> UIImage
    {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result ?? CustomMethods.placeholderImageWithSize(CGSize(width: 150, height: 150))!
        })
        return thumbnail
    }
    
    static func placeholderImageWithSize(_ size : CGSize) -> UIImage?
    {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()

        let backgroundColor = UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
        let iconColor = UIColor(red: 179.0 / 255.0, green: 179.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
        
        // Background
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        // Icon (back)
        let backIconRect = CGRect(x: size.width * (16.0 / 68.0), y: size.height * (20.0 / 68.0), width: size.width * (32.0 / 68.0), height: size.height * (24.0 / 68.0))

        context?.setFillColor(iconColor.cgColor)
        context?.fill(backIconRect)

        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(backIconRect.insetBy(dx: 1.0, dy: 1.0))
        
        
        // Icon (front)
        let frontIconRect = CGRect(x: size.width * (20.0 / 68.0), y: size.height * (24.0 / 68.0), width: size.width * (32.0 / 68.0), height: size.height * (24.0 / 68.0))

        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(frontIconRect.insetBy(dx: -1.0, dy: -1.0))

        context?.setFillColor(iconColor.cgColor)
        context?.fill(frontIconRect)

        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(frontIconRect.insetBy(dx: 1.0, dy: 1.0))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    static func getStringValue(keyString:String, dictionary dict:[String:Any]) -> String
    {
        if let value = dict[keyString] as? NSNumber
        {
            return value.stringValue
        }
        else if let value = dict[keyString] as? String
        {
            return value
        }
        
        return ""
    }
    
    
    static func getDictionaryValue(keyString:String, dictionary dict:[String:Any]) -> [String:Any]?
    {
        if let value = dict[keyString] as? [String:Any]
        {
            return value
        }
        return nil
    }
    
    static func getDictArrayValue(keyString:String, dictionary dict:[String:Any]) -> [[String : Any]]?
    {
        if let value = dict[keyString] as? [[String : Any]]
        {
            return value
        }
        return  nil
    }
    
    

}
