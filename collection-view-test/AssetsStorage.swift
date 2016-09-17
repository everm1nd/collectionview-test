//
//  AssetsStorage.swift
//  collection-view-test
//
//  Created by Nikita Simakov on 14.09.16.
//  Copyright © 2016 Nikita Simakov. All rights reserved.
//

import Foundation
import Photos

class AssetsStorage {
    // THIS IS A SINGLETON, 👶
    static let sharedInstance = AssetsStorage()
    private init() {}
    
    var assets = NSMutableSet()
}
