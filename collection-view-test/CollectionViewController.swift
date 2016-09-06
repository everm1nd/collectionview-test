//
//  CollectionViewController.swift
//  collection-view-test
//
//  Created by Nikita Simakov on 04.09.16.
//  Copyright © 2016 Nikita Simakov. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    class Moment {
        var assets = [PHAsset]()
        var collection: PHAssetCollection?
        
        init(collection: PHAssetCollection) {
            self.collection = collection
            
            let assets = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
            assets.enumerateObjectsUsingBlock({ (asset, _, _) in
                self.assets.append(asset as! PHAsset)
            })
        }
    }
    
    var moments = [Moment]()
    var imageManager: PHCachingImageManager!
    
    let imageSize = CGSize(width: 150, height: 150)
    
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        let side = self.view.frame.width / 10
//        layout.itemSize = self.view.frame.size
        layout.itemSize = CGSize(width: side, height: side)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.imageManager = PHCachingImageManager()
        
        collectionView?.allowsMultipleSelection = true

        warmupImages()
    }
    
//    func photoForIndexPath(indexPath: NSIndexPath) -> UIImage {
//        debugPrint(indexPath)
//        return moments[indexPath.section].photos[indexPath.row]
//    }
    
    func assetForIndexPath(indexPath: NSIndexPath) -> PHAsset {
        debugPrint(indexPath)
        return moments[indexPath.section].assets[indexPath.row]
    }
    
    func warmupImages() -> Void {
        moments = [Moment]() // reset an array.
                                 // TODO: better use deinitialize, right?
        
        let collections = PHAssetCollection.fetchMomentsWithOptions(nil)
        collections.enumerateObjectsUsingBlock({ collection, momentIndex, _ in
            self.moments.append(Moment(collection: collection as! PHAssetCollection))
        })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return moments.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moments[section].assets.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        
        let asset = assetForIndexPath(indexPath)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .HighQualityFormat
        options.resizeMode = .Exact
        
        PHImageManager.defaultManager().requestImageForAsset(
            asset,
            targetSize: self.imageSize,
            contentMode: .AspectFill,
            options: options,
            resultHandler: {
                image, info in
                cell.imageView.image = image
            }
        )
    
        return cell
    }
    
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
//        cell.layer.borderWidth = 5
//        cell.layer.borderColor = UIColor.redColor().CGColor
//        debugPrint("cell selected: ", cell)
//    }
//    
//    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
//        cell.layer.borderWidth = 0
//        cell.layer.borderColor = UIColor.redColor().CGColor
//    }
    
    
//    // set cell size
//    func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
    
    override func collectionView(collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "CollectionHeaderView",
                                                                      forIndexPath: indexPath)
                    as! CollectionHeaderView
//            headerView.label.text = moments[indexPath.section].collection!.localizedTitle
            headerView.update(moments[indexPath.section].collection!)
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }

}
