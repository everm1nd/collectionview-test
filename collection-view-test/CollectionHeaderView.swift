//
//  CollectionHeaderView.swift
//  collection-view-test
//
//  Created by Nikita Simakov on 04.09.16.
//  Copyright © 2016 Nikita Simakov. All rights reserved.
//

import UIKit
import Photos

class CollectionHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var label: UILabel!
    
    var collection: PHAssetCollection!
    
    func update(_ collection: PHAssetCollection) -> UICollectionReusableView {
        self.collection = collection
        self.label.text = titleFromCollection(collection)
        return self
    }
    
    fileprivate func titleFromCollection(_ collection: PHAssetCollection) -> String {
        // TODO: can be possibly extracted to utils module
        func stringFromDate(_ startDate: Date, toDate: Date) -> String {
            let formatter = DateIntervalFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            
            return formatter.string(from: startDate, to: toDate)
        }
        
        if let text = collection.localizedTitle {
            return text
        } else {
            return stringFromDate(collection.startDate!, toDate: collection.endDate!)
        }
    }
    
    @IBAction func selectMoment(_ sender: AnyObject) {
        debugPrint("moment selected:", self.collection)
    }
}
