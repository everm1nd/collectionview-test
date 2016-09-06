//
//  CollectionViewCell.swift
//  collection-view-test
//
//  Created by Nikita Simakov on 04.09.16.
//  Copyright © 2016 Nikita Simakov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let borderWidth: Int = 2
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor.redColor().CGColor
    }
    
    override var selected: Bool {
        get {
            return super.selected
        }
        set(selected) {
            super.selected = selected
            self.layer.borderWidth = CGFloat( selected ? borderWidth : 0 )
        }
    }
    
}
