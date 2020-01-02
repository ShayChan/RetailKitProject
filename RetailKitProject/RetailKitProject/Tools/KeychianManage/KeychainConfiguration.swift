//
//  DSKeychainConfiguration.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 4/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

struct BDKeychainConfiguration {
    
    static let serviceName = "com.dada.bd"
    
    static let accessGroup = "4K46345F2F." + serviceName
    
    //iCloud
    static let bSecAttrSynchronizable : CFBoolean = kCFBooleanFalse
}
