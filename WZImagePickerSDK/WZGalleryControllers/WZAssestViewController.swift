//
//  WZAssestViewController.swift
//  WZImagePickerSDK
//
//  Created by Adeel on 19/02/2020.
//  Copyright © 2020 Adeel. All rights reserved.
//

import UIKit
import Photos

protocol WzSelectedSingleAlbumsPictureDelegate {
    func didFinishSelectionOfAlbumsPicture(_ mediaAssest : [PHAsset])
    func didCancelForSelection()
}


class WZAssestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    /**************************************************************************************/
    // MARK: -  ------------------------ Declarations -----------------------------
    /**************************************************************************************/
    
    var phassetCollection   : PHAssetCollection?      = nil
    var resultCollection    : PHFetchResult<PHAsset>? = nil
    var albumTitle          : String?                 = nil
    var delegate            : WzSelectedSingleAlbumsPictureDelegate?
    var selectedImagesIndex = [Int]()
    
    var backgroundColor     : UIColor?                = nil
    var imagesCorners       : CGFloat?                = nil
    var selectedImageColor  : UIColor?                = nil
    var selectedMediaType   : Int?                    = nil
    var selectionType                                 : SelectionType?
    
    var totalCountReq                                 = 0
    var currentPageCounter                            = 1
    var currentMeidaCounter                           = 0
    var pagePerMedia                                  = 150
    
    /**************************************************************************************/
    // MARK: -  ------------------------ Outlets -----------------------------
    /**************************************************************************************/
    
    @IBOutlet weak var collectionviewForAllImages   : UICollectionView!
    @IBOutlet weak var activityIndicator            : UIActivityIndicatorView!
    @IBOutlet weak var pictureBackgoundView         : UIView!
    @IBOutlet weak var doneBarButton                : UIBarButtonItem!
    @IBOutlet weak var cancelBarButton              : UIBarButtonItem!
    
    /**************************************************************************************/
    // MARK: -  ------------------------ ViewControllers lifeCycle -----------------------------
    /**************************************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchOptions                = PHFetchOptions()
        //fetchOptions.predicate          = NSPredicate(format: "mediaType == \(self.selectedMediaType)") // NSPredicate(format: "title = %@", albumTitle) //
        if (selectedMediaType != nil)
        {
            fetchOptions.predicate = NSPredicate(format: "mediaType == \(selectedMediaType ?? 1)")
        }
        else
        {
            fetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        }
        //fetchOptions.predicate          = NSPredicate(format: "mediaType == \(self.selectedMediaType)")
        fetchOptions.sortDescriptors    = [NSSortDescriptor(key: "creationDate", ascending: false)]
        resultCollection                = PHAsset.fetchAssets(in: phassetCollection!, options: fetchOptions)
        
        //print(resultCollection)
        
        if (backgroundColor != nil)
        {
            pictureBackgoundView.backgroundColor = backgroundColor
        }
        
//        collectionviewForAllImages.register(UINib(nibName: "WZAssestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WZAssestCollectionViewCell")
    }

    /**************************************************************************************/
    // MARK: -  ------------- CollectionView Delegate and DataSource -----------------
    /**************************************************************************************/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return resultCollection?.count ?? 0
    }
    
    /**************************************************************************************/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: "WZAssestCollectionViewCell", for: indexPath) as! WZAssestCollectionViewCell
        let assest              = resultCollection?[indexPath.item]
        //let assestImage         = imagesAndAssestForAllPhotots[assest?.localIdentifier ?? ""]
        if selectedImagesIndex.contains(indexPath.item)
        {
            var selectColor = UIColor()
            if selectedImageColor != nil
            {
                selectColor = selectedImageColor!
            }
            else
            {
                selectColor = .blue
            }
            cell.selectedIndicator.backgroundColor = selectColor
        }
        else
        {
            cell.selectedIndicator.backgroundColor = UIColor.white
        }
        
        if (imagesCorners != nil)
        {
            cell.imageView.layer.cornerRadius   = imagesCorners!
        }
        
        //cell.populateCellsData(assestImage ?? nil)
        cell.populateCellDataWithAssets(assest)
//        if (indexPath.item == currentPageCounter * pagePerMedia)
//        {
//            self.currentPageCounter += 1
//            getMediaInChunks()
//        }
        
        return cell
    }
    
    /**************************************************************************************/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        CustomMethods.standardSizeOfcollectionviewCell(collectionviewForAllImages.frame.width)
    }
    
    /**************************************************************************************/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectionType == SelectionType.singleSelection
        {
            selectedImagesIndex = [indexPath.item]
        }
        else
        {
            if selectionType == SelectionType.singleSelection
            {
                selectedImagesIndex = [indexPath.item]
            }
            else
            {
                if selectedImagesIndex.contains(indexPath.item)
                {
                    selectedImagesIndex.removeAll{$0 == indexPath.item}
                }
                else
                {
                    selectedImagesIndex.append(indexPath.item)
                }
            }
        }
        collectionviewForAllImages.reloadData()
    }
    
    
    @IBAction func cancelBarButtonTapped(_ sender: Any)
    {
        //delegate?.didCancelForSelection()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneBarButtonTapped(_ sender: Any) {
        
        var assestToTransfer = [PHAsset]()
        for index in selectedImagesIndex
        {
            if let assest                      = resultCollection?[index]
            {
                assestToTransfer.append(assest)
            }
        }
        
        if assestToTransfer.count > 0
        {
            delegate?.didFinishSelectionOfAlbumsPicture(assestToTransfer)
        }
        
    }
}
