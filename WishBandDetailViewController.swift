//
//  WishBandDetailViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/12/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class WishBandDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var band: WishBandInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.delegate = self
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "importPicture")
        
        if let band = band {
            image.image = band.bandImage
            name.text = band.bandName
            title = band.bandName
        }
        checkNameValid()
    }
    
    // Text field stuff
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
        let text = name.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // Picture Stuff
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage = UIImage()
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        }
        dismissViewControllerAnimated(true, completion: nil)
        image.image = newImage
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let bandName = name.text ?? ""
            let bandImage = image.image
            band = WishBandInfo(name: bandName, image: bandImage)
            
        }
    }
}
