//
//  CancelledBandInfo.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/30/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class CancelledBandInfo: NSObject, NSCoding {

    var bandName: String
    var bandImage: UIImage?
    var reason: String?
    
    // Archiving path
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("cancelledBand")
    
    // Types
    struct PropertyKey {
        static let bandNameKey = "bandName"
        static let bandImageKey = "bandImage"
        static let reasonKey = "reason"
    }
    
    
    init?(bandName: String, bandImage: UIImage?, reason: String?) {
        self.bandImage = bandImage
        self.bandName = bandName
        self.reason = reason
        super.init()
        
        if bandName.isEmpty {
            return nil
        }
    }
    
    // NSCoding for a single band
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bandName, forKey: PropertyKey.bandNameKey)
        aCoder.encodeObject(bandImage, forKey: PropertyKey.bandImageKey)
        aCoder.encodeObject(reason, forKey: PropertyKey.reasonKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.bandNameKey) as! String
        let image = aDecoder.decodeObjectForKey(PropertyKey.bandImageKey) as? UIImage
        let reason = aDecoder.decodeObjectForKey(PropertyKey.reasonKey) as? String
        
        // call its designated initializer
        self.init(bandName: name, bandImage: image, reason: reason)
    }

}
