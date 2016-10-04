//
//  AchievementTableViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/21/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class AchievementTableViewController: UITableViewController {
    // Properties
    var achievedBand = [AchieveBandInfo]()
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YOUR GIG ACHIEVEMENT"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissVC")
        self.tableView.allowsMultipleSelection = false
        if let savedAchievedBand = loadAchievedBand() {
            achievedBand += savedAchievedBand
        } else {
            loadSamples()
        }

    }
    
    // Dismiss VC
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //        <#code#>
    //    }
    
    // load samples function
    func loadSamples() {
        let sampleImage1 = UIImage(named: "thecribs")!
        let sampleBand1 = AchieveBandInfo(bandName: "The Cribs", bandImage: sampleImage1, date: "2016.09.17", location: "Shanghai", repo: nil)!
        
        let sampleImage2 = UIImage(named: "odell")!
        let sampleBand2 = AchieveBandInfo(bandName: "Tom Odell", bandImage: sampleImage2, date: "2014.11.30", location: "Shanghai", repo: nil)!
        
        let sampleImage3 = UIImage(named: "stereophonics")!
        let sampleBand3 = AchieveBandInfo(bandName: "Stereophonics", bandImage: sampleImage3, date: "2016.07.29", location: "Shanghai", repo: nil)!
        
        achievedBand.append(sampleBand1)
        achievedBand.append(sampleBand2)
        achievedBand.append(sampleBand3)
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
        return achievedBand.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AchievementTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AchievementTableViewCell
        let band = achievedBand[indexPath.row]
        cell.bandImage.image = band.bandImage
        cell.bandName.text = band.bandName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowAchievementDetail", sender: self)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // implement deletion
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            // delete items from data source(从数据源删除)
            self.achievedBand.removeAtIndex(indexPath.row)
            self.saveAchievedBand()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [deleteAction]
    }
    
    // NSCoding for wish list band
    func saveAchievedBand() {
        // This method attempts to archive the achievedBand array to a specific location, and returns true if it’s successful
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(achievedBand, toFile: AchieveBandInfo.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save band list")
        }
    }
    
    func loadAchievedBand() -> [AchieveBandInfo]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(AchieveBandInfo.ArchiveURL.path!) as? [AchieveBandInfo]
    }
    
    // prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowAchievementDetail" {
    
            let vc = segue.destinationViewController as! AchievementDetailViewController
            
            if let selectedCell = sender as? AchievementTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                vc.achievedBand = achievedBand[indexPath.row]
            }
        } else if segue.identifier == "AddItem" {
            print("Add new achievement")
        }
    }
    
    // unwind segue
    @IBAction func unwindToAchievementDetail(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AchievementDetailViewController, achieveBand = sourceViewController.achievedBand {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                achievedBand[selectedIndexPath.row] = achieveBand
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndex = NSIndexPath(forRow: achievedBand.count, inSection: 0)
                achievedBand.append(achieveBand)
                tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation: .Bottom)
            }
            saveAchievedBand()
        }
    }
}
