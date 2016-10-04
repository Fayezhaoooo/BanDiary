//
//  CancallationDetailViewController.swift
//  BanDiary
//
//  Created by ZhaoYanfei on 9/30/16.
//  Copyright © 2016 FayeZhao. All rights reserved.
//

import UIKit

class CancallationDetailViewController: UIViewController {

    @IBOutlet weak var bandImage: UIImageView!
    @IBOutlet weak var bandName: UITextField!
    @IBOutlet weak var reason: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
