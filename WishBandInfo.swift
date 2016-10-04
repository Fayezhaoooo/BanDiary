//
//  BandInfo.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/5/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class WishBandInfo: NSObject, NSCoding {
    
    // Properties
    var bandName: String
    var bandImage: UIImage?
    
    // Archiving path
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("wishListBand")
    
    // Types
    struct PropertyKey {
        static let bandNameKey = "bandName"
        static let bandImageKey = "bandImage"
    }
    
    // Designated initializer
    init?(name: String, image: UIImage?) {
        bandName = name
        bandImage = image
        // Call its superclass initializer
        super.init()
        
        if name.isEmpty {
            return nil
        }
        
    }
    
    // NSCoding for a single band
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bandName, forKey: PropertyKey.bandNameKey)
        aCoder.encodeObject(bandImage, forKey: PropertyKey.bandImageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.bandNameKey) as! String
        let image = aDecoder.decodeObjectForKey(PropertyKey.bandImageKey) as? UIImage
        // call its designated initializer
        self.init(name: name, image: image)
    }
}
