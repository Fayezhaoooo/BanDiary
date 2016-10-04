//
//  AchievementDetailViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/25/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit
import QBImagePickerController

class AchievementDetailViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, QBImagePickerControllerDelegate {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextFiel: UITextField!
    @IBOutlet weak var repoTextView: UITextView!
    @IBOutlet weak var bandName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var imagesArray = [UIImage]()
    var achievedBand: AchieveBandInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bandName.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "importPictures")
        
        if let achievedBand = achievedBand {
           bandName.text = achievedBand.bandName
           // collectionView's images ?????
            dateTextField.text = achievedBand.date
            locationTextFiel.text = achievedBand.location
            repoTextView.text = achievedBand.repo
            
            
        }
        
        checkNameValid()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // import pictures actions:
    func importPictures() {
        let picker = QBImagePickerController()
        picker.delegate = self
        picker.allowsMultipleSelection = true
        picker.minimumNumberOfSelection = 1
        // why i still can select more than 9 pics even if i've set this shit to 9???
        picker.maximumNumberOfSelection = 9
        picker.showsNumberOfSelectedAssets = true
        self.presentViewController(picker, animated: true, completion: nil)

    }
    
    // QBImagePickerControllerDelegate Methods
    // MESS.!!!
    func qb_imagePickerController(imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        var selectedImages = [UIImage]()
        for asset in assets {
            if let possibleImage = asset[UIImagePickerControllerOriginalImage] as? UIImage {
                selectedImages.append(possibleImage)
            } else if let possibleImage = asset[UIImagePickerControllerEditedImage] as? UIImage {
                selectedImages.append(possibleImage)
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        imagesArray += selectedImages
    }
    
    func qb_imagePickerControllerDidCancel(imagePickerController: QBImagePickerController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func qb_imagePickerController(imagePickerController: QBImagePickerController!, shouldSelectAsset asset: PHAsset!) -> Bool {
        return true
    }
    
    
    // Text Field stuff
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkNameValid()
        title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkNameValid() {
        let text = bandName.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    // Save data
    @IBAction func save(sender: AnyObject) {
    }

    // Collection View delegate
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        var cell = UICollectionViewCell()
        cell = collectionView.cellForItemAtIndexPath(indexPath)! as UICollectionViewCell
        cell.backgroundColor = UIColor.yellowColor()
    }
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
    // CollectionView Data Source
    // TOTAL MESS HERE
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "AchievementImageCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! AchieveImageCollectionViewCell
        let achieveImage = imagesArray[indexPath.row]
        cell.achievementImage.image = achieveImage
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
     //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = bandName.text ?? ""
            let date = dateTextField.text
            let location = locationTextFiel.text
            let repo = repoTextView.text
            achievedBand = AchieveBandInfo(bandName: name, bandImage: nil, date: date, location: location, repo: repo)
        }
        
    }
    

}
