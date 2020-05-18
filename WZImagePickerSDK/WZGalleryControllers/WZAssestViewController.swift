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
    var selectedImageIcon   : UIImage?                = nil
    var selectedMediaType   : Int?                    = nil
    var selectionType                                 : SelectionType?
    
    var totalCountReq                                 = 0
    var currentPageCounter                            = 1
    var currentMeidaCounter                           = 0
    var pagePerMedia                                  = 150
    
    private let sectionInsetsPictures = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 2.0, right: 3.0)
    
    /**************************************************************************************/
    // MARK: -  ------------------------ Outlets -----------------------------
    /**************************************************************************************/
    
    @IBOutlet weak var collectionviewForAllImages   : UICollectionView!
    @IBOutlet weak var activityIndicator            : UIActivityIndicatorView!
    @IBOutlet weak var pictureBackgoundView         : UIView!
    @IBOutlet weak var cancelBarButton              : UIBarButtonItem!
    
    @IBOutlet var navigationBar                   : UINavigationBar!
    
    /**************************************************************************************/
    // MARK: -  ------------------------ ViewControllers lifeCycle -----------------------------
    /**************************************************************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.title = "TooDo"
        self.title = albumTitle ?? "Pictures"
        
        updateDoneButtonState()
        
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
        //fetchOptions.sortDescriptors    = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        resultCollection                = PHAsset.fetchAssets(in: phassetCollection!, options: fetchOptions)
        
        if (backgroundColor != nil)
        {
            pictureBackgoundView.backgroundColor = backgroundColor
        }
    }
    
    func updateDoneButtonState() {
        
        if (selectedImagesIndex.count > 0)
        {
            if (self.navigationItem.rightBarButtonItem == nil)
            {
                let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBarButtonTapped))
                self.navigationItem.rightBarButtonItem = doneBarButton
            }
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil
        }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WZAssestCollectionViewCell", for: indexPath) as! WZAssestCollectionViewCell
        
        let assest = resultCollection?[indexPath.item]
        if selectedImagesIndex.contains(indexPath.item)
        {
            if (selectedImageIcon != nil)
            {
                cell.selectedIconImageView.image = selectedImageIcon
                cell.selectedIconImageView.isHidden = false
                cell.selectedAlphaView.isHidden = false
            }
            else
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
                cell.selectedIconImageView.tintColor = selectColor
                cell.selectedIconImageView.isHidden = false
                cell.selectedAlphaView.isHidden = false
            }
        }
        else
        {
            cell.selectedIconImageView.isHidden = true
            cell.selectedAlphaView.isHidden = true
        }
        
        if (imagesCorners != nil)
        {
            cell.imageView.layer.cornerRadius   = imagesCorners!
        }
            
        cell.populateCellDataWithAssets(assest)
        
        return cell
    }
    
    /**************************************************************************************/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectionType == SelectionType.singleImageSelection
        {
            //selectedImagesIndex = [indexPath.item]
            
            if let assest = resultCollection?[indexPath.item]
            {
                delegate?.didFinishSelectionOfAlbumsPicture([assest])
            }
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
            
            collectionviewForAllImages.reloadData()
            
            updateDoneButtonState()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CustomMethods.getSizeOfcollectionviewCell(collectionviewForAllImages.frame.width, sectionInsets: sectionInsetsPictures)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsetsPictures
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsetsPictures.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                
        return sectionInsetsPictures.left
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBarButtonTapped(_ sender: Any) {
        
        var assestToTransfer = [PHAsset]()
        for index in selectedImagesIndex
        {
            if let assest = resultCollection?[index]
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
