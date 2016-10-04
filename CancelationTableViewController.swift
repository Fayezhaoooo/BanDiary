//
//  CancelationTableViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/21/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class CancelationTableViewController: UITableViewController {
    // Properties
    var cancelledBand = [CancelledBandInfo]()
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "THE BAND YOU CANNOT SEE LIVE"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissVC")
        self.tableView.allowsMultipleSelection = false
        loadSamples()
    }
    
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        <#code#>
    //    }
    
    // load samples function
    func loadSamples() {
        let sampleImage1 = UIImage(named: "liam")!
        let sampleBand1 = CancelledBandInfo(bandName: "OASIS", bandImage: sampleImage1, reason: nil)!
        
        cancelledBand.append(sampleBand1)
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cancelledBand.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CancelationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CancelationTableViewCell
        let band = cancelledBand[indexPath.row]
        cell.bandImage.image = band.bandImage
        cell.bandName.text = band.bandName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // implement deletion
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            // delete items from data source(从数据源删除)
            self.cancelledBand.removeAtIndex(indexPath.row)
            self.saveCancelledBand() // need to write this method
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
    }
    
    // helper function: dismiss view controller
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // NSCoding for wish list band
    func saveCancelledBand() {
        // This method attempts to archive the achievedBand array to a specific location, and returns true if it’s successful
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(cancelledBand, toFile: CancelledBandInfo.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save band list")
        }
    }
    
    func loadAchievedBand() -> [CancelledBandInfo]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(CancelledBandInfo.ArchiveURL.path!) as? [CancelledBandInfo]
    }

    
}
