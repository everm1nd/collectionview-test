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
    
    func update(collection: PHAssetCollection) -> UICollectionReusableView {
        self.collection = collection
        self.label.text = titleFromCollection(collection)
        return self
    }
    
    private func titleFromCollection(collection: PHAssetCollection) -> String {
        // TODO: can be possibly extracted to utils module
        func stringFromDate(startDate: NSDate, toDate: NSDate) -> String {
            let formatter = NSDateIntervalFormatter()
            formatter.dateStyle = NSDateIntervalFormatterStyle.MediumStyle
            formatter.timeStyle = NSDateIntervalFormatterStyle.NoStyle
            
            return formatter.stringFromDate(startDate, toDate: toDate)
        }
        
        if let text = collection.localizedTitle {
            return text
        } else {
            return stringFromDate(collection.startDate!, toDate: collection.endDate!)
        }
    }
    
    @IBAction func selectMoment(sender: AnyObject) {
        debugPrint("moment selected:", self.collection)
    }
}
