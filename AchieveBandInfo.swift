//
//  AchieveBandInfo.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/26/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class AchieveBandInfo: NSObject, NSCoding {
    
    var bandName: String
    var bandImage: UIImage?
    var date: String?
    var location: String?
    var repo: String?
    
    // Archiving path
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("achievedBand")

    // Types
    struct PropertyKey {
        static let bandNameKey = "bandName"
        static let bandImageKey = "bandImage"
        static let dateKey = "date"
        static let locationKey = "location"
        static let repoKey = "repo"
    }

    
    init?(bandName: String, bandImage: UIImage?, date: String?, location: String?, repo: String?) {
        self.bandImage = bandImage
        self.bandName = bandName
        self.date = date
        self.location = location
        self.repo = repo
        
        super.init()
        
        if bandName.isEmpty {
            return nil
        }
    }
    
    // NSCoding for a single band
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(bandName, forKey: PropertyKey.bandNameKey)
        aCoder.encodeObject(bandImage, forKey: PropertyKey.bandImageKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(location, forKey: PropertyKey.locationKey)
        aCoder.encodeObject(repo, forKey: PropertyKey.repoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.bandNameKey) as! String
        let image = aDecoder.decodeObjectForKey(PropertyKey.bandImageKey) as? UIImage
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? String
        let location = aDecoder.decodeObjectForKey(PropertyKey.locationKey) as? String
        let repo = aDecoder.decodeObjectForKey(PropertyKey.repoKey) as? String
        // call its designated initializer
        self.init(bandName: name, bandImage: image, date: date, location: location, repo: repo)
    }

    

}
