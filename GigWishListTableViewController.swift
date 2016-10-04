//
//  GigWishListTableViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/5/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit
class GigWishListTableViewController: UITableViewController {
   // Properties
    var wishListBand = [WishBandInfo]()

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YOUR BAND WISH LIST"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: "dismissVC")
        self.tableView.allowsMultipleSelection = false
        if let savedWishListBand = loadWishListBand() {
            wishListBand += savedWishListBand
        } else {
        loadSamples()
        }
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
    // Implementing the delete and move to function
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let moveAction = UITableViewRowAction(style: .Default, title: "Move") { (action, indexPath) in
        let moveMenu = UIAlertController(title: nil, message: "Move to", preferredStyle: .ActionSheet)
            
            // I need to write two handler to handle the movements
            let cancelationAction = UIAlertAction(title: "Move to Cancelation List", style: .Default, handler: {
                (action: UIAlertAction) in
            self.performSegueWithIdentifier("MoveToCancelationList", sender: tableView.cellForRowAtIndexPath(indexPath))
            })
            let achievementAction = UIAlertAction(title: "Move to Achievement List", style: .Default, handler: {
                (action: UIAlertAction) in
                self.performSegueWithIdentifier("MoveToAchievementList", sender: tableView.cellForRowAtIndexPath(indexPath))
            })
            let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            moveMenu.addAction(cancelationAction)
            moveMenu.addAction(achievementAction)
            moveMenu.addAction(cancel)
            self.presentViewController(moveMenu, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            // delete items from data source(从数据源删除)
            self.wishListBand.removeAtIndex(indexPath.row)
            self.saveWishListBand()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        moveAction.backgroundColor = UIColor.lightGrayColor()
        deleteAction.backgroundColor = UIColor.redColor()
        
        return [moveAction, deleteAction]
    }
    
    // load samples function
    func loadSamples() {
        let sampleImage1 = UIImage(named: "blur2")!
        let sampleBand1 = WishBandInfo(name: "Blur", image: sampleImage1)!
        
        let sampleImage2 = UIImage(named: "noel")!
        let sampleBand2 = WishBandInfo(name: "NGHFB", image: sampleImage2)!
        
        wishListBand.append(sampleBand1)
        wishListBand.append(sampleBand2)
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
        return wishListBand.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WishListTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WishListTableViewCell
        let band = wishListBand[indexPath.row]
        cell.bandImage.image = band.bandImage
        cell.bandName.text = band.bandName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // unwind segue
    @IBAction func unwindforWishList(sender: UIStoryboardSegue) {
        if let sourceVC = sender.sourceViewController as? WishBandDetailViewController, band = sourceVC.band {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                wishListBand[selectedIndexPath.row] = band
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
            let newIndex = NSIndexPath(forRow: wishListBand.count, inSection: 0)
            wishListBand.append(band)
            tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation: .Bottom)
            }
            saveWishListBand()
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destinationViewController as! WishBandDetailViewController
            if let selectedCell = sender as? WishListTableViewCell {
                let indextPath = tableView.indexPathForCell(selectedCell)!
                let selectedBand = wishListBand[indextPath.row]
                detailVC.band = selectedBand
                
            }
            
        } else if segue.identifier == "AddItem" {
            print("add a new band wish")
        }
        // CANCELATION MOVEMENT SEGUE
        else if segue.identifier == "MoveToCancelationList" {
            let cancelationVC = segue.destinationViewController as! CancelationTableViewController
            if let selectedCell = sender as? WishListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedBand = wishListBand[indexPath.row]
                
                // selected row need to be deleted from wish list                        
                self.wishListBand.removeAtIndex(indexPath.row)
                self.saveWishListBand()
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                // and move to cancelation list
                let band = CancelledBandInfo(bandName: selectedBand.bandName, bandImage: selectedBand.bandImage, reason: nil)!
                cancelationVC.cancelledBand.append(band)
            }
        }
        // ACHIEVEMENT MOVEMENT SEGUE
        else if segue.identifier == "MoveToAchievementList" {
            let achievementVC = segue.destinationViewController as! AchievementTableViewController
            if let selectedCell = sender as? WishListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedBand = wishListBand[indexPath.row]
                
                // selected row need to be deleted from wish list
                self.wishListBand.removeAtIndex(indexPath.row)
                self.saveWishListBand()
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                // and move to achievement list
                let band = AchieveBandInfo(bandName: selectedBand.bandName, bandImage: selectedBand.bandImage, date: nil, location: nil, repo: nil)!
                achievementVC.loadSamples()
                achievementVC.achievedBand.append(band)
                achievementVC.saveAchievedBand()

            }
        }
    }
    
    // helper function: dismiss view controller
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // NSCoding for wish list band
    func saveWishListBand() {
        // This method attempts to archive the wishListBand array to a specific location, and returns true if it’s successful
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(wishListBand, toFile: WishBandInfo.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save band list")
        }
    }
    
    func loadWishListBand() -> [WishBandInfo]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(WishBandInfo.ArchiveURL.path!) as? [WishBandInfo]
    }

}
