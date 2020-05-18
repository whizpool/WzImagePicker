//
//  ViewController.swift
//  WZPickerTest
//
//  Created by Adeel on 31/03/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import UIKit
import Photos
import WZImagePickerSDK

class ViewController: UIViewController, WZImagePickerDelegate {
    
    @IBOutlet weak var labelTesting : UILabel!
    
    var mediaCollectionString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func didFinishPickImage(_ mediaAssest: [PHAsset]) {
        
        mediaCollectionString = ""

        var totalVideo = 0
        var totalimages = 0
        for asset in mediaAssest
        {
            if asset.mediaType == .video
            {
                totalVideo += 1
            }
            else if asset.mediaType == .image
            {
                totalimages += 1
            }
        }

        mediaCollectionString += "total images is : \(totalimages)\ntotal video is : \(totalVideo)\n\ntotal media is : \(mediaAssest.count)\n"

        labelTesting.text = mediaCollectionString
        
        DispatchQueue.main.async {
            
            self.dismiss(animated: true, completion: nil)
        }
    }

    func didCancelPickImage() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage?
    {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail :  UIImage?
        option.isSynchronous = true

        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result
        })
        return thumbnail
    }


    @IBAction func openWzpickerTapped(_ sender : UIButton)
    {
        let wzPicker = WZPickerController()
        wzPicker.delegate = self

//        wzPicker.backgroundColor                = UIColor(red: 31/255, green: 30/255, blue: 45/255, alpha: 1)
//        wzPicker.barTintColor                   = UIColor.lightGray
//        wzPicker.tintColor                      = UIColor.black
//        wzPicker.topSelectionButtonColor        = UIColor(red: 41/255, green: 40/255, blue: 56/255, alpha: 1)
//        wzPicker.topButtonTextColor             = UIColor.white
//        wzPicker.topHighlightedIndicatorColor   = UIColor.yellow
//        wzPicker.albumsCellBackgoundColor       = UIColor.clear
//        wzPicker.albumsBorderCorners            = 0
//        //wzPicker.albumsImageBorderColors        = UIColor.yellow
//        wzPicker.albumsTextColor                = UIColor(red: 163/255, green: 162/255, blue: 162/255, alpha: 1)
//        wzPicker.selectedImageColor             = UIColor.yellow
//        wzPicker.albumPreviewCorners            = 10
//        wzPicker.imagesBorderWidth              = 0
//        //wzPicker.selectedMediaType              = .images
//        wzPicker.selectionType                  = .multiImageSelection
//        wzPicker.selectedImageIcon              = UIImage(named: "check_icon")

        wzPicker.show(self)
    }
}
