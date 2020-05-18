//
//  Common.swift
//  imagePickerWz
//
//  Created by Adeel on 20/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import Foundation
import UIKit
import Photos

/// protocol delegate method  for return back data to accesssable viewcontroller
public protocol WZImagePickerDelegate {
    
    func didFinishPickImage(_ mediaAssest : [PHAsset])
    func didCancelPickImage()
}

public class WZPickerController: NSObject, WzSelectedPictureDelegate {
    
    
    /// if these variables are nil than use default behaviour
    public var backgroundColor               : UIColor?               = nil /// accessable varibale for set main background color of screen
    public var barTintColor                  : UIColor?               = nil /// accessable varibale for set bar tint color
    public var tintColor                     : UIColor?               = nil /// accessable varibale for set tint color
    public var topSelectionButtonColor       : UIColor?               = nil /// accessable varibale for set top button selections backgound color
    public var topHighlightedIndicatorColor  : UIColor?               = nil ///  accessable varibale for set selected button highlight view's color
    public var topButtonTextColor            : UIColor?               = nil ///  accessable varibale for set top selection buttons text color
    public var albumsCellBackgoundColor      : UIColor?               = nil ///  accessable varibale for set each cells backgound color
//    public var albumsImageBorderColors       : UIColor?               = nil ///  accessable varibale for set each cells border color
    public var albumsTextColor               : UIColor?               = nil ///  accessable varibale for set each cells text color
    public var selectedImageColor            : UIColor?               = nil ///  accessable varibale for set selected images indicator color
    public var selectedImageIcon             : UIImage?               = nil ///  accessable varibale for set selected images icon
    public var albumsBorderCorners           : CGFloat?               = nil ///  accessable varibale for set each cell border
    public var albumPreviewCorners           : CGFloat?               = nil ///  accessable varibale for set album preview image corners
    public var pictureCorners                : CGFloat?               = nil ///  accessable varibale for set picture corners
    public var imagesBorderWidth             : CGFloat?               = nil ///  accessable varibale for set images border
    public var selectedMediaType             : SelectedMediaType?     = nil ///  accessable varibale for set media type either video or image if nil than both
    public var selectionType                 : SelectionType?         = nil ///  accessable varibale for set single selection or multiple selection
    public var delegate                      : WZImagePickerDelegate? = nil///  accessable varibale for set delagte
    
    public var selectAllAlbum                : Bool                   = false
    
    
    public func show(_ fromController : UIViewController)
    {
        //        let wzAlbums                = WZAlbumsViewController()
        
        let podBundle  = Bundle(for: type(of: self))
        let storyboard = UIStoryboard(name: "WzPicker", bundle: podBundle)
        let wzAlbums   = storyboard.instantiateViewController(withIdentifier: "WZAlbumsViewController") as! WZAlbumsViewController
        
        if (backgroundColor != nil)
        {
            wzAlbums.backgroundColor    = backgroundColor
        }
        
        if (barTintColor != nil)
        {
            wzAlbums.barTintColor    = barTintColor
        }
        
        if (tintColor != nil)
        {
            wzAlbums.tintColor    = tintColor
        }
        
        if (topSelectionButtonColor != nil)
        {
            wzAlbums.topSectionColor    = topSelectionButtonColor
        }
        
        if (topHighlightedIndicatorColor != nil)
        {
            wzAlbums.highLightedIndicatorColor    = topHighlightedIndicatorColor
        }
        
        if (albumsCellBackgoundColor != nil)
        {
            wzAlbums.albumsCellBackgoundColor    = albumsCellBackgoundColor
        }
        
//        if (albumsImageBorderColors != nil)
//        {
//            wzAlbums.albumsImageBorderColor    = albumsImageBorderColors
//        }
        
        if (albumsBorderCorners != nil)
        {
            wzAlbums.albumsBorderCorners    = albumsBorderCorners
        }
        
        if (albumPreviewCorners != nil)
        {
            wzAlbums.albumPreviewCorners    = albumPreviewCorners
        }
        
        if (pictureCorners != nil)
        {
            wzAlbums.pictureCorners    = pictureCorners
        }
        
        if (imagesBorderWidth != nil)
        {
            wzAlbums.imagesBorderWidth    = imagesBorderWidth
        }
        
        if (albumsTextColor != nil)
        {
            wzAlbums.albumsTextColor    = albumsTextColor
        }
        
        if (selectedImageColor != nil)
        {
            wzAlbums.selectedImageColor    = selectedImageColor
        }
        
        if (selectedImageIcon != nil)
        {
            wzAlbums.selectedImageIcon    = selectedImageIcon
        }
        
        if (topButtonTextColor != nil)
        {
            wzAlbums.topButtonsTextColor     = topButtonTextColor
        }
        
        if (selectedMediaType != nil)
        {
            wzAlbums.selectedType       = selectedMediaType
        }
        
        if (selectionType != nil)
        {
            wzAlbums.selectionType      = selectionType
        }
        
        wzAlbums.selectAllAlbum = selectAllAlbum
        wzAlbums.delegate = self
        
        let navController = UINavigationController.init(rootViewController: wzAlbums)
        fromController.present(navController, animated: true, completion: nil)
        //fromController.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    /**************************************************************************************/
    // MARK: -  ---------------- Custom Delegate Methods ---------------
    /**************************************************************************************/
    
    /// after image selection done from all photos or each albums phonts than this delagte method called and same delegate will again call tu custom user class
    func didFinishSelection(_ mediaAssest: [PHAsset]) {
        delegate?.didFinishPickImage(mediaAssest)
    }
    
    func didCancel() {
        //print("Cancelled")
        delegate?.didCancelPickImage()
    }
    
}

